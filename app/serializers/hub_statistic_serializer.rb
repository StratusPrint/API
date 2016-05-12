class HubStatisticSerializer < ActiveModel::Serializer
  attributes :jobs_in_progress, :queued_jobs, :processing_jobs, :current_wait_time, :ready_printers, :busy_printers, :errored_printers, :completed_printers, :paused_printers, :offline_printers, :cancelled_printers, :attached_printers
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
  self.printers.where(:status => 'ready').count
end

def busy_printers
  self.printers.where(:status => ['printing', 'paused']).count
end

def errored_printers
  self.printers.where(:status => 'errored').count
end

def completed_printers
  self.printers.where(:status => 'completed').count
end

def paused_printers
  self.printers.where(:status => 'paused').count
end

def printing_printers
  self.printers.where(:status => 'printing').count
end

def offline_printers
  self.printers.where(:status => 'offline').count
end

def cancelled_printers
  self.printers.where(:status => 'cancelled').count
end

def attached_printers
  self.printers.count
end
