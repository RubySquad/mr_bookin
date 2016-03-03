FactoryGirl.define do
  factory :address do
    address { Faker::Address.street_address }
    zipcode { Faker::Address.zip_code }
    city { Faker::Address.city }
    phone { Faker::PhoneNumber.phone_number }
    country { Country.find_or_create_by(name: Faker::Address.country) }
    user
  end
end
