FactoryGirl.define do
  sequence :printer_name do |n|
    "printer#{n}"
  end

  factory :printer do
    friendly_id { generate(:printer_name) }
    status { ["idle", "printing", "online", "offline"].sample }
    manufacturer "Printrbot"
    model "Play"
    desc "Used to print models for project XYZ."

    after(:create) do |printer|
      5.times do printer.jobs << create(:job) end
      printer.num_jobs = 5
    end
  end
end
