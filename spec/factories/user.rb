FactoryGirl.define do
  sequence :email do |n|
    "testuser#{n}@stratusprint.com"
  end

  sequence :user_ip do |n|
    IPAddr.new(n, Socket::AF_INET).to_s
  end

  factory :user do
    name "John Smith"
    nickname "John"
    email { generate(:email) }
    password "12345678"
    admin false
    last_sign_in_ip { generate(:ip) }
    last_sign_in_at Time.now
    current_sign_in_ip { generate(:ip) }
    current_sign_in_at Time.now
    created_at Time.now
    default_hub_id 0
  end

  factory :admin, class: User do
    name "Admin User"
    nickname "Admin"
    email "admin@stratusprint.com"
    password "12345678"
    admin true
    last_sign_in_ip { generate(:user_ip) }
    last_sign_in_at Time.now
    current_sign_in_ip { generate(:user_ip) }
    current_sign_in_at Time.now
    created_at Time.now
    default_hub_id 0
  end
end
