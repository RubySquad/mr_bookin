FactoryGirl.define do
  factory :order do
    # state "MyString"
    # completed_date "2016-02-03 14:07:38"
    total_price { Faker::Commerce.price }
    user
    # credit_card
    shipping_address { build(:address).to_s }
    billing_address { build(:address).to_s }
  end
end
