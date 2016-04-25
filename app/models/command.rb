class Command < ApplicationRecord
  swagger_schema :Command do
    key :required, [:name]
    property :id do
      key :type, :integer
      key :format, :int64
      key :description, 'The unique ID of the command'
    end
    property :issued_by do
      key :type, :string
      key :description, 'The name of the user who issued the command'
    end
    property :created_at do
      key :type, :string
      key :format, 'date-time'
      key :description, 'When the command was issued'
    end
    property :executed_at do
      key :type, :string
      key :format, 'date-time'
      key :description, 'When the command was executed'
    end
    property :status do
      key :type, :string
      key :enum, ['issued', 'executed', 'errored']
      key :description, 'The status of the command (e.g. whether it was successfully executed or not.)'
    end
    property :type do
      key :type, :string
      key :enum, ['start', 'pause', 'cancel']
      key :description, 'The type of command issued'
    end
  end

  enumerize :status, in: [:issued, :executed, :errored]
  enumerize :name, in: [:start, :pause, :cancel]

  validates :name, :presence => true

  attr_readonly :issued_by_user, :name

  has_one :printer_command
  has_one :printer, through: :printer_command
end
