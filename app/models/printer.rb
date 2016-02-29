class Printer < ApplicationRecord
  include Swagger::Blocks

  swagger_schema :Printer do
    key :required, [:id, :friendly_id, :manufacturer, :model, :label, :status, :num_jobs]
    property :id do
      key :type, :integer
      key :format, :int64
    end
    property :friendly_id do
      key :type, :string
    end
    property :manufacturer do
      key :type, :string
    end
    property :model do
      key :type, :string
    end
    property :label do
      key :type, :string
    end
    property :status do
      key :type, :string
    end
    property :num_jobs do
      key :type, :integer
      key :format, :int64
    end
  end

  validates :friendly_id, :uniqueness => true

  has_one :hub_printer
  has_one :hub, through: :hub_printer
  has_many :printer_jobs
  has_many :jobs, through: :printer_jobs
end
