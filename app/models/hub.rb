class Hub < ApplicationRecord
  validates :friendly_id, :uniqueness => true

  has_many :hub_printers
  has_many :hub_sensors
  has_many :printers, through: :hub_printers
  has_many :sensors, through: :hub_sensors

  # Include default devise modules.
  devise :database_authenticatable, :trackable
  include DeviseTokenAuth::Concerns::User
end
