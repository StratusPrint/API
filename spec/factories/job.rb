FactoryGirl.define do
  sequence :id do |n|
    n
  end

  factory :job do
    created_at { Time.at(rand(12.hours.ago.to_f..Time.now.to_f)) }
    updated_at { Time.now }
    id { generate(:id) }
  end
end
