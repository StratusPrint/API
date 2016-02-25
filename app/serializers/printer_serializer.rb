class PrinterSerializer < ActiveModel::Serializer
  attributes :id, :friendly_id, :label, :manufacturer, :model, :status, :jobs

  def jobs
    object.jobs.as_json
  end
end
