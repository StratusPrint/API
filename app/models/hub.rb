class Hub < ApplicationRecord
  before_create :gen_api_key
  validates :friendly_id, :uniqueness => true

  has_many :hub_printers
  has_many :hub_sensors
  has_many :printers, through: :hub_printers
  has_many :sensors, through: :hub_sensors

  # Include default devise modules.
  devise :database_authenticatable, :trackable
  include DeviseTokenAuth::Concerns::User

  private

  def gen_api_key
    begin
      self.api_token = SecureRandom.hex
      self.uid = api_token
    end while self.class.exists?(api_token: api_token)
  end
end
