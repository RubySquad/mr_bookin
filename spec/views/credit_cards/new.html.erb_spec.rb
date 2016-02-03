require 'rails_helper'

RSpec.describe "credit_cards/new", type: :view do
  before(:each) do
    assign(:credit_card, CreditCard.new(
      :number => "MyString",
      :cvv => "MyString",
      :exp_month => 1,
      :exp_year => 1,
      :firstname => "MyString",
      :lastname => "MyString",
      :user => nil
    ))
  end

  it "renders new credit_card form" do
    render

    assert_select "form[action=?][method=?]", credit_cards_path, "post" do

      assert_select "input#credit_card_number[name=?]", "credit_card[number]"

      assert_select "input#credit_card_cvv[name=?]", "credit_card[cvv]"

      assert_select "input#credit_card_exp_month[name=?]", "credit_card[exp_month]"

      assert_select "input#credit_card_exp_year[name=?]", "credit_card[exp_year]"

      assert_select "input#credit_card_firstname[name=?]", "credit_card[firstname]"

      assert_select "input#credit_card_lastname[name=?]", "credit_card[lastname]"

      assert_select "input#credit_card_user_id[name=?]", "credit_card[user_id]"
    end
  end
end
