FactoryGirl.define do
  factory :book do
    title { Faker::Book.title }
    description { Faker::Hipster.paragraph }
    price { Faker::Commerce.price }
    stock { Faker::Number.number(2) }
    author
    category
  end
end
