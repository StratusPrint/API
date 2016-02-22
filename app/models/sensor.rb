class Sensor < ApplicationRecord
  has_one :hub_sensor
  has_one :hub, through: :hub_sensor
end
