class Alert < ApplicationRecord
  swagger_schema :Alert do
    key :required, [:name]
    property :id do
      key :type, :integer
      key :format, :int64
      key :description, 'The unique ID of the alert'
    end
    property :category do
      key :type, :string
      key :enum, ['sensor', 'job', 'printer']
      key :description, 'The type of alert'
    end
    property :title do
      key :type, :string
      key :description, 'The title of alert'
    end
    property :message do
      key :type, :string
      key :description, 'The alert message'
    end
    property :time do
      key :type, 'date-time'
      key :description, 'The time when the alert was generated'
    end
    property :time do
      key :type, :string
      key :description, 'A snapshot of the environment taken when the alert was generated'
    end
  end

  enumerize :category, in: [:hub, :printer, :job, :sensor]

  serialize :sensors, JSON
end
