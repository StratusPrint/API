class Hub < ApplicationRecord
  before_create :gen_api_key
  validates :friendly_id, :uniqueness => true

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
