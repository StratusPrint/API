class Hub < ApplicationRecord
  has_many :hub_printers
  has_many :hub_sensors
  has_many :printers, through: :hub_printers
  has_many :sensors, through: :hub_sensors
end

class HubPrinter < ApplicationRecord
  belongs_to :hub
  belongs_to :printer
end

class HubSensor < ApplicationRecord
  belongs_to :hub
  belongs_to :sensor
end
