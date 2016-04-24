FactoryGirl.define do
  sequence :sensor_name do |n|
    "sensor#{n}"
  end

  factory :sensor do
    friendly_id { generate(:sensor_name) }
    category { ["temperature", "humidity", "door"].sample }
    manufacturer "MicroChip"
    model "SENSOR-4000"
    desc "Detects environmental condition XYZ."

    after(:create) do |sensor|
      case sensor.category
      when "temperature"
        10.times do sensor.data_points << create(:temperature_data_point) end
      when "humidity"
        10.times do sensor.data_points << create(:humidity_data_point) end
      when "door"
        10.times do sensor.data_points << create(:door_data_point) end
      end
    end
  end
end
