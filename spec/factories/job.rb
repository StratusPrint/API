FactoryGirl.define do
  sequence :file do |n|
    "model#{n}.stl"
  end

  factory :job do
    file { generate(:file) }
    status { ["active", "completed", "paused", "cancelled", "errored"].sample }
    duration { rand(1..7200) }
    progress { rand(0.0..1.0) }
    started { Time.at(rand(12.hours.ago.to_f..Time.now.to_f)) }
    completed { Time.now }
  end
end
