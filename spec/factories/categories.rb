FactoryGirl.define do
  factory :category do
    title { Category.find_or_create_by(title: Faker::Book.genre) }
  end
end
