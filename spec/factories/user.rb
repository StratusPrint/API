FactoryGirl.define do
  sequence :email do |n|
    "testuser#{n}@stratusprint.com"
  end

  factory :user do
    name "John Smith"
    nickname "John"
    email { generate(:email) }
    password "12345678"
    admin false
  end

  factory :admin, class: User do
    name "Admin User"
    nickname "Admin"
    email "admin@stratusprint.com"
    password "12345678"
    admin true
  end
end
