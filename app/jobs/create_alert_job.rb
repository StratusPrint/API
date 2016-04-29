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
      # create a job alert
    when Printer
      # create a printer alert
    when Hub
      # create a hub alert
    end
  end

  private

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
