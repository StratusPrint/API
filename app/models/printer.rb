class Printer < ApplicationRecord
  include Swagger::Blocks
  extend Enumerize

  swagger_schema :Printer do
    key :required, [:friendly_id, :manufacturer, :model]
    property :id do
      key :type, :integer
      key :description, 'The unique ID of the printer'
    end
    property :friendly_id do
      key :type, :string
      key :description, 'The user defined (friendly) unique ID of the printer'
    end
    property :manufacturer do
      key :type, :string
      key :description, 'The manufacturer of the printer'
    end
    property :model do
      key :type, :string
      key :description, 'The model name of the printer'
    end
    property :status do
      key :type, :string
      key :description, 'The current status of the printer'
      key :enum, ['idle', 'printing', 'online', 'offline']
    end
    property :num_jobs do
      key :type, :integer
      key :description, 'The number of current and previous jobs managed by the printer'
    end
  end

  validates :friendly_id, :uniqueness => true, :presence => true

  enumerize :status, in: [:idle, :printing, :online, :offline]

  has_one :hub_printer
  has_one :hub, through: :hub_printer
  has_many :printer_jobs
  has_many :jobs, through: :printer_jobs, dependent: :destroy
end
