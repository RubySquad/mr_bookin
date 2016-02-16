FactoryGirl.define do
  factory :book do
    title { Faker::Book.title }
    description { Faker::Hipster.paragraph(5, true, 5) }
    price { Faker::Commerce.price }
    stock { Faker::Number.number(2) }
    author
    category { Category.find_or_create_by(title: Faker::Book.genre) }
  end
end
