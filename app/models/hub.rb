class Hub < ApplicationRecord
  before_create :gen_api_key

  has_many :hub_printers
  has_many :hub_sensors
  has_many :printers, through: :hub_printers
  has_many :sensors, through: :hub_sensors

  private

  def gen_api_key
    begin
      self.api_key = SecureRandom.hex
    end while self.class.exists?(api_key: api_key)
  end
end

class HubPrinter < ApplicationRecord
  belongs_to :hub
  belongs_to :printer
end

class HubSensor < ApplicationRecord
  belongs_to :hub
  belongs_to :sensor
end
