FactoryGirl.define do
  factory :credit_card do
    temp_date = Faker::Date.forward(23)
    number { Faker::Business.credit_card_number }
    cvv "123"
    exp_month { temp_date.month }
    exp_year { temp_date.year }
    firstname { Faker::Name.first_name }
    lastname  { Faker::Name.last_name }
    user
  end
end
