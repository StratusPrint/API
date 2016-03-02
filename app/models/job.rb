class Job < ApplicationRecord
  include Swagger::Blocks

  swagger_schema :Job do
    key :required, [:file]
    property :id do
      key :type, :integer
      key :description, 'The unique ID of the print job'
    end
    property :file do
      key :type, :string
      key :description, 'The name of the file being printed'
    end
    property :started do
      key :type, :string
      key :format, 'date-time'
      key :description, 'The time the print job was started'
    end
    property :completed do
      key :type, :string
      key :format, 'date-time'
      key :description, 'The time the print job was completed'
    end
    property :status do
      key :type, :string
      key :description, 'The current status of the print job'
      key :enum, ['active', 'completed', 'paused', 'cancelled', 'errored']
    end
    property :duration do
      key :type, :integer
      key :description, 'The amount of time, in seconds, that the print job was running for'
    end
    property :progress do
      key :type, :integer
      key :description, 'The percentage completion of the print job'
    end
  end

  has_one :printer_job
  has_one :printer, through: :printer_job
end
