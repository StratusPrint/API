FactoryGirl.define do
  factory :user do
    name 'John Smith'
    nickname 'John'
    email 'johnsmith@stratusprint.com'
    password '12345678'
    admin false
  end

  factory :admin, class: User do
    name 'Admin User'
    nickname 'Admin'
    email 'admin@stratusprint.com'
    password '12345678'
    admin true
  end
end
