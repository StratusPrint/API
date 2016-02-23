class Sensor < ApplicationRecord
  validates :friendly_id, :uniqueness => true

  has_one :hub_sensor
  has_one :hub, through: :hub_sensor
  has_many :sensor_data_points
  has_many :data_points, through: :sensor_data_points
end
