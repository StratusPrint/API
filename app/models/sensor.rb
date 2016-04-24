class Sensor < ApplicationRecord
  swagger_schema :Sensor do
    key :required, [:friendly_id, :manufacturer, :model, :category]
    property :id do
      key :type, :integer
      key :description, 'The unique ID of the sensor'
    end
    property :friendly_id do
      key :type, :string
      key :description, 'The user defined (friendly) unique ID of the sensor'
    end
    property :category do
      key :type, :string
      key :description, 'The type of sensor'
      key :enum, ['temperature', 'humidity', 'infrared']
    end
    property :manufacturer do
      key :type, :string
      key :description, 'The manufacturer of the sensor'
    end
    property :model do
      key :type, :string
      key :description, 'The model name of the sensor'
    end
    property :desc do
      key :type, :string
      key :description, 'An optional description of the sensor'
    end
    property :data_count do
      key :type, :integer
      key :description, 'The number of data entries logged by the sensor'
    end
  end

  before_destroy :destroy_data

  validates :friendly_id, :uniqueness => true, :presence => true

  enumerize :category, in: [:temperature, :humidity, :door]

  has_one :hub_sensor
  has_one :hub, through: :hub_sensor
  has_many :sensor_data_points
  has_many :data_points, through: :sensor_data_points

  private
  def destroy_data
    self.data_points.destroy_all
  end
end
