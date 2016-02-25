class SensorSerializer < ActiveModel::Serializer
  attributes :id, :friendly_id, :category, :manufacturer, :model, :desc, :data

  def data
    object.data_points.as_json(except: [:id, :update_at])
  end
end
