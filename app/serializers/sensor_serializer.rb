class SensorSerializer < ActiveModel::Serializer
  attributes :id, :friendly_id, :category, :manufacturer, :model, :desc, :data_count, :reading, :low_threshold, :high_threshold

  def data_count
    object.data_points.count
  end

  def reading
    if object.data_points.empty?
      return ""
    else
      return object.data_points.last.value
    end
  end
end
