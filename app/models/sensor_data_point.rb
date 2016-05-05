class SensorDataPoint < ApplicationRecord
  belongs_to :sensor
  belongs_to :data_point, :dependent => :destroy
end
