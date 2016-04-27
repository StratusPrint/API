class SensorSerializer < ActiveModel::Serializer
  attributes :id, :friendly_id, :category, :manufacturer, :model, :desc, :data_count, :reading

  def data_count
    object.data_points.count
  end

  def reading
    object.data_points.last.value
  end
end
