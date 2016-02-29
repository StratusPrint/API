class Job < ApplicationRecord
  include Swagger::Blocks

  swagger_schema :Job do
    key :required, [:id, :file, :started, :completed, :status, :duration, :progress, :status_code]
    property :id do
      key :type, :integer
      key :format, :int64
    end
    property :file do
      key :type, :string
    end
    property :started do
      key :type, :string
    end
    property :completed do
      key :type, :string
    end
    property :status do
      key :type, :string
    end
    property :duration do
      key :type, :integer
    end
    property :progress do
      key :type, :integer
    end
    property :status_code do
      key :type, :string
    end
  end

  has_one :printer_job
  has_one :printer, through: :printer_job
end
