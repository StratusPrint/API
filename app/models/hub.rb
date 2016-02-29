class Hub < ApplicationRecord
  include Swagger::Blocks

  swagger_schema :Hub do
    key :required, [:id, :friendly_id, :ip, :hostname, :location, :label]
    property :id do
      key :type, :integer
      key :format, :int64
    end
    property :friendly_id do
      key :type, :string
    end
    property :ip do
      key :type, :string
    end
    property :hostname do
      key :type, :string
    end
    property :location do
      key :type, :string
    end
    property :label do
      key :type, :string
    end
  end

  validates :friendly_id, :uniqueness => true

  has_many :hub_printers
  has_many :hub_sensors
  has_many :printers, through: :hub_printers
  has_many :sensors, through: :hub_sensors

  # Include default devise modules.
  devise :database_authenticatable, :trackable
  include DeviseTokenAuth::Concerns::User
end
