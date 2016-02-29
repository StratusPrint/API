class Sensor < ApplicationRecord
  include Swagger::Blocks

  swagger_schema :Sensor do
    key :required, [:id, :friendly_id, :manufacturer, :model, :label, :desc, :data_count]
    property :id do
      key :type, :integer
      key :format, :int64
    end
    property :friendly_id do
      key :type, :string
    end
    property :manufacturer do
      key :type, :string
    end
    property :model do
      key :type, :string
    end
    property :label do
      key :type, :string
    end
    property :desc do
      key :type, :string
    end
    property :data_count do
      key :type, :integer
      key :format, :int64
    end
  end

  validates :friendly_id, :uniqueness => true

  has_one :hub_sensor
  has_one :hub, through: :hub_sensor
  has_many :sensor_data_points
  has_many :data_points, through: :sensor_data_points
end
