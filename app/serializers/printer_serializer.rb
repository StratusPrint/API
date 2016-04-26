class PrinterSerializer < ActiveModel::Serializer
  attributes :id, :updated_at, :friendly_id, :manufacturer, :model, :num_jobs, :description, :status

  def num_jobs
    object.jobs.count
  end
end
