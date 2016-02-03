FactoryGirl.define do
  factory :rating do
    review "MyText"
    rating 1
    user nil
    book nil
  end
end
