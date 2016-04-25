FactoryGirl.define do
  sequence :hub_name do |n|
    "hub#{n}"
  end

  sequence :ip do |n|
    IPAddr.new(n, Socket::AF_INET).to_s
  end

  sequence :hostname do |n|
    "hub#{n}.stratusprint.com"
  end

  factory :hub do
    friendly_id { generate(:hub_name) }
    ip { generate(:ip) }
    hostname { generate(:hostname) }
    location "Secret Location 1234"
    desc "Manages the printers and sensors of a deployment."
    status { ["online", "offline", "unknown"].sample }

    after(:build) do |hub|
      2.times do hub.printers << build(:printer) end
      5.times do hub.sensors << build(:sensor) end
    end
  end
end
