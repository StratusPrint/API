class Printer < ApplicationRecord
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
    property :num_jobs do
      key :type, :integer
      key :description, 'The number of current and previous jobs managed by the printer'
    end
    property :description do
      key :type, :string
      key :description, 'A description of what the printer for organizational purposes.'
    end
    property :status do
      key :type, :string
      key :description, 'The status of the printer'
      key :enum, ['ready', 'paused', 'printing', 'errored', 'offline', 'cancelled', 'completed']
    end
  end

  before_destroy :destroy_jobs

  validates :friendly_id, :uniqueness => true, :presence => true
  enumerize :status, in: [:ready, :paused, :printing, :errored, :offline, :cancelled, :completed]

  has_one :hub_printer, :dependent => :destroy
  has_one :hub, through: :hub_printer
  has_many :printer_jobs
  has_many :jobs, through: :printer_jobs
  has_many :printer_commands, :dependent => :destroy
  has_many :commands, through: :printer_commands

  serialize :data, JSON

  private
  def destroy_jobs
    self.jobs.destroy_all
  end
end
