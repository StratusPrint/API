class Hub < ApplicationRecord
  include Swagger::Blocks

  swagger_schema :Hub do
    key :required, [:friendly_id, :ip, :hostname]
    property :id do
      key :type, :integer
      key :description, 'The unique ID of the hub'
    end
    property :friendly_id do
      key :type, :string
      key :description, 'The user defined (friendly) unique ID of the hub'
    end
    property :ip do
      key :type, :string
      key :description, 'The IPv4 address of the hub'
    end
    property :hostname do
      key :type, :string
      key :description, 'The hostname (FQDN) of the hub'
    end
    property :location do
      key :type, :string
      key :description, 'The location where the hub is installed on-site'
    end
    property :desc do
      key :type, :string
      key :description, 'An optional description of the hub'
    end
    property :status do
      key :type, :string
      key :description, 'The current status of the hub'
      key :enum, ['online', 'offline', 'unknown']
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
