FactoryGirl.define do
  # sequence :email do |n|
  #   "email#{n}@factory.com"
  # end

  factory :user do
    email { Faker::Internet.email }
    firstname { Faker::Name.first_name }
    lastname  { Faker::Name.last_name }
    password { Faker::Internet.password }
    role
  end
end
