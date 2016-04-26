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
    property :data do
      key :title, 'data'
      property :state do
        key :title, 'state'
        property :text do
          key :type, :string
          key :description, 'A textual representation of the current state of the printer, e.g. "Operational" or "Printing"'
          key :enum, ['Operational', 'Paused', 'Printing', 'SD Ready', 'Error', 'Ready', 'Closed or Error']
        end
        property :flags do
          key :title, 'flags'
          property :operational do
            key :type, :boolean
            key :description, 'true if the printer is operational, false otherwise'
          end
          property :paused do
            key :type, :boolean
            key :description, 'true if the printer is currently paused, false otherwise'
          end
          property :printing do
            key :type, :boolean
            key :description, 'true if the printer is currently printing, false otherwise'
          end
          property :sdReady do
            key :type, :boolean
            key :description, 'true if the printer’s SD card is available and initialized, false otherwise'
          end
          property :error do
            key :type, :boolean
            key :description, 'true if an unrecoverable error occurred, false otherwise'
          end
          property :ready do
            key :type, :boolean
            key :description, 'true if the printer is operational and no data is currently being streamed to SD, so ready to receive instructions'
          end
          property :closedOrError do
            key :type, :boolean
            key :description, 'true if the printer is disconnected (possibly due to an error), false otherwise'
          end
        end
      end
    end
  end

  before_destroy :destroy_jobs

  validates :friendly_id, :uniqueness => true, :presence => true
  enumerize :status, in: [:ready, :paused, :printing, :errored, :offline, :cancelled, :completed]

  has_one :hub_printer
  has_one :hub, through: :hub_printer
  has_many :printer_jobs
  has_many :jobs, through: :printer_jobs
  has_many :printer_commands
  has_many :commands, through: :printer_commands

  serialize :data, JSON

  private
  def destroy_jobs
    self.jobs.destroy_all
  end
end
