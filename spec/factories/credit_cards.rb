FactoryGirl.define do
  factory :credit_card do
    number "MyString"
    cvv "MyString"
    exp_month 1
    exp_year 1
    firstname "MyString"
    lastname "MyString"
    user nil
  end
end
