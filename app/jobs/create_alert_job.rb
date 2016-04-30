class CreateAlertJob < ApplicationJob
  queue_as :default

  def perform(type, *args)
    case type
    when Sensor
      @sensor = type
      @data_point = args[0]
      logger.info "Creating an alert for sensor ##{@sensor.id}"
      create_sensor_alert
    when Job
      @job = type
      @new_status = args[0]
      @old_status = args[1]
      logger.info "Creating an alert for job ##{@job.id} due to a status change from #{@old_status.upcase} to #{@new_status.upcase}"
      create_job_alert
    when Printer
      # create a printer alert
    when Hub
      # create a hub alert
    end
  end

  private
  def create_job_alert
    if @new_status == 'errored'
      @alert = Alert.new(:snapshot => environment_conditions, :category => 'job', :title => build_job_status_change_title, :message => build_job_status_change_message, :time => @job.updated_at)
    else
      @alert = Alert.new(:category => 'job', :title => build_job_status_change_title, :message => build_job_status_change_message, :time => @job.updated_at)
    end
    if @alert.save
      send_job_status_change_email
    end
  end

  def send_job_status_change_email
    AlertMailer.notify(@alert, User.find(@job.created_by_user_id).email).deliver
  end

  def build_job_status_change_title
    if @new_status == 'errored'
      "[ALERT] Job ##{@job.id} (#{@job.model_file_name}#{File.extname(@job.model.url)}) has #{@new_status.upcase}"
    else
      "[ALERT] Job ##{@job.id} (#{@job.model_file_name}#{File.extname(@job.model.url)}) is now #{@new_status.upcase}"
    end
  end

  def build_job_status_change_message
    if @new_status == 'errored'
      "The job has failed and is no longer printing."
    else
      "The job status has changed from #{@old_status} to #{@new_status}."
    end
  end

  def environment_conditions
    sensors = @job.printer.hub.sensors
    array = Array.new
    sensors.each do |s|
      reading = friendly_reading(s)
      s = s.as_json
      s['reading'] = reading
      array.push s
    end
    return array
  end

  def create_sensor_alert
    if @sensor.alert_generated
      send_threshold_violation_email
    else
      send_back_to_normal_email
    end
  end

  def send_threshold_violation_email
    @alert = Alert.new(:category => 'sensor', :title => build_threshold_violation_title, :message => build_threshold_violation_message, :time => @data_point.created_at)
    if @alert.save
      User.all.each { |u| AlertMailer.notify(@alert, u.email).deliver }
    end
  end

  def send_back_to_normal_email
    @alert = Alert.new(:category => 'sensor', :title => build_back_to_normal_title, :message => build_back_to_normal_message, :time => @data_point.created_at)
    if @alert.save
      User.all.each { |u| AlertMailer.notify(@alert, u.email).deliver }
    end
  end

  def build_back_to_normal_message
    "The #{@sensor.category} is currently at #{@data_point.value}#{sensor_unit} and within the normal range of #{@sensor.low_threshold}#{sensor_unit} - #{@sensor.high_threshold}#{sensor_unit}."
  end

  def build_back_to_normal_title
    "[ALERT] Sensor ##{@sensor.id} (#{@sensor.friendly_id}) - #{@sensor.category.capitalize} Back to Normal"
  end

  def build_threshold_violation_message
    if @data_point.value.to_i < @sensor.low_threshold.to_i
      "The #{@sensor.category} fell below the low threshold of #{@sensor.low_threshold}#{sensor_unit} and is currently at #{@data_point.value}#{sensor_unit}."
    else
      "The #{@sensor.category} rose above the high threshold of #{@sensor.high_threshold}#{sensor_unit} and is currently at #{@data_point.value}#{sensor_unit}."
    end
  end

  def build_threshold_violation_title
    "[ALERT] Sensor ##{@sensor.id} (#{@sensor.friendly_id}) - #{@sensor.category.capitalize} Threshold Violated"
  end

  def friendly_reading(sensor)
    case sensor.category
    when "temperature"
      return "#{sensor.data_points.last.value.to_i.round(2)}°F"
    when "humidity"
      return "#{sensor.data_points.last.value.to_i.round(2)}%"
    when "door"
      return "OPEN" if sensor.data_points.last.value == '0'
      return "CLOSED" if sensor.data_points.last.value == '1'
    end
  end

  def sensor_unit
    case @sensor.category
    when "temperature"
      "°F"
    when "humidity"
      '%'
    when "door"
      ""
    end
  end
end
