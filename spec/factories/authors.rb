FactoryGirl.define do
  factory :author do
    firstname { Faker::Name.first_name }
    lastname  { Faker::Name.last_name }
    biography { Faker::Hipster.paragraph(13, true, 4) }
  end
end
