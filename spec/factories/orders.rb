FactoryGirl.define do
  factory :order do
    state "MyString"
    completed_date "2016-02-03 14:07:38"
    total_price "9.99"
    user nil
    credit_card nil
    shipping_address "MyText"
    billing_address "MyText"
  end
end
