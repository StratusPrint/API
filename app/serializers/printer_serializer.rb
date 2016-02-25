class PrinterSerializer < ActiveModel::Serializer
  attributes :id, :friendly_id, :label, :manufacturer, :model, :status
end
