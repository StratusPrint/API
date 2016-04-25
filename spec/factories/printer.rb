FactoryGirl.define do
  sequence :printer_name do |n|
    "printer#{n}"
  end

  factory :printer do
    friendly_id { generate(:printer_name) }
    manufacturer "Printrbot"
    model "Play"
    description "Used to print models for project XYZ."

    after(:build) do |printer|
      5.times do printer.jobs << build(:job) end
      printer.num_jobs = 5
    end
  end
end
