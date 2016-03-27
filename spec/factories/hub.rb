FactoryGirl.define do
  sequence :friendly_id do |n|
    "hub#{n}"
  end

  sequence :ip do |n|
    IPAddr.new(n, Socket::AF_INET).to_s
  end

  sequence :hostname do |n|
    "hub#{n}.stratusprint.com"
  end

  factory :hub do |h|
    friendly_id { generate(:friendly_id) }
    ip { generate(:ip) }
    hostname { generate(:hostname) }
    location 'Secret Location 1234'
    desc 'Manages the printers and sensors of a deployment.'
    status { ['online', 'offline', 'unknown'].sample }
  end
end
