class DataPoint < ApplicationRecord
  has_one :sensor_data_point
  has_one :sensor, through: :sensor_data_point
end
