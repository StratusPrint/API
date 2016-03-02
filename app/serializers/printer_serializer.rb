class PrinterSerializer < ActiveModel::Serializer
  attributes :id, :friendly_id, :manufacturer, :model, :status, :num_jobs

  def num_jobs
    object.jobs.count
  end
end
