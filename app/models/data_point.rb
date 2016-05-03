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

  scope :days_ago, -> num_days { where(:created_at => (Time.zone.now-num_days.to_i.days..Time.zone.now)) }
  scope :hours_ago, -> num_hours { where(:created_at => (Time.zone.now-num_hours.to_i.hours..Time.zone.now)) }

  def violates_threshold?
    (self.value.to_i <= self.sensor.low_threshold.to_i) || (self.value.to_i >= self.sensor.high_threshold.to_i)
  end

  def is_normal?
    (self.value.to_i > self.sensor.low_threshold.to_i) && (self.value.to_i < self.sensor.high_threshold.to_i)
  end
end
