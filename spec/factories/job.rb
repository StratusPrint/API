FactoryGirl.define do
  sequence :id do |n|
    n
  end

  factory :job do
    created_at { Time.at(rand(12.hours.ago.to_f..Time.now.to_f)) }
    updated_at { Time.now }
    created_by_user_id { create(:user).id }
    id { generate(:id) }
    model_file_name { "planet_gear" }
    model { "data:application/stl;base64,R0lGODlhPQ==" }
  end
end
