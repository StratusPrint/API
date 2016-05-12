FactoryGirl.define do
  factory :temperature_data_point, class: DataPoint do
    created_at { Time.at(rand(24.hours.ago.to_f..Time.now.to_f)) }
    value { rand(0.0..100.0).to_s }
  end
end
