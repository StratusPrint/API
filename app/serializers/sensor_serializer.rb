class SensorSerializer < ActiveModel::Serializer
  attributes :id, :friendly_id, :category, :manufacturer, :model, :desc, :data_count

  def data_count
	object.data_points.count
  end
end

