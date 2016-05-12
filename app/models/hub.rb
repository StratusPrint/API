class Hub < ApplicationRecord
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
    property :nodes do
      key :type, :array
      key :description, 'List of nodes associated with the hub'
      items do
        key :type, :integer
      end
    end
  end

  before_destroy :destroy_sensors_printers

  validates :friendly_id, :hostname, :uniqueness => true, :presence => true
  validates :ip, :uniqueness => true, :presence => true, :ip => { :format => :v4 }
  validates_format_of :hostname, :with => /\A[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}\z/ix
  validates_inclusion_of :port, in: 0..65535

  enumerize :status, in: [:online, :offline, :unknown]

  has_many :hub_printers, :dependent => :destroy
  has_many :hub_sensors, :dependent => :destroy
  has_many :printers, through: :hub_printers
  has_many :sensors, through: :hub_sensors

  # Include default devise modules.
  devise :database_authenticatable, :trackable
  include DeviseTokenAuth::Concerns::User

  private
  def destroy_sensors_printers
    self.sensors.destroy_all
    self.printers.destroy_all
  end
end
