class HubStatisticSerializer < ActiveModel::Serializer
  attributes :jobs_in_progress, :queued_jobs, :processing_jobs, :current_wait_time, :ready_printers, :busy_printers
end

def jobs_in_progress
  num_in_progress = 0
  self.printers.each do |p|
    p.jobs.each do |j|
      num_in_progress += 1 if j.data['status'] == 'printing'
    end
  end
  return num_in_progress
end

def queued_jobs
  queued = 0
  self.printers.each do |p|
    p.jobs.each do |j|
      queued += 1 if j.data['status'] == 'queued'
    end
  end
  return queued
end

def processing_jobs
  queued = 0
  self.printers.each do |p|
    p.jobs.each do |j|
      queued += 1 if j.data['status'] == 'processing'
    end
  end
  return queued
end

def current_wait_time
  durations = Array.new
  self.printers.each do |p|
    p.jobs.each do |j|
      durations.push(j.data['progress']['print_time_left']) if j.data['status'] == 'printing'
    end
  end
  if durations.empty?
    return 0
  else
    return durations.min
  end
end

def ready_printers
  num_ready = 0;
  self.printers.each do |p|
    num_ready += 1 if p.data['state']['flags']['ready']
  end
  return num_ready
end

def busy_printers
  num_busy = 0
  self.printers.each do |p|
    num_busy += 1 if not p.data['state']['flags']['ready']
  end
  return num_busy
end
