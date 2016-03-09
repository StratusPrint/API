class DataPoint < ApplicationRecord
  swagger_schema :DataPoint do
    key :required, [:id, :created_at, :value]
    property :id do
      key :type, :integer
      key :format, :int64
    end
    property :created_at do
      key :type, :string
    end
    property :value do
      key :type, :string
    end
  end

  has_one :sensor_data_point
  has_one :sensor, through: :sensor_data_point
end
