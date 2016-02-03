require 'rails_helper'

RSpec.describe "credit_cards/index", type: :view do
  before(:each) do
    assign(:credit_cards, [
      CreditCard.create!(
        :number => "Number",
        :cvv => "Cvv",
        :exp_month => 1,
        :exp_year => 2,
        :firstname => "Firstname",
        :lastname => "Lastname",
        :user => nil
      ),
      CreditCard.create!(
        :number => "Number",
        :cvv => "Cvv",
        :exp_month => 1,
        :exp_year => 2,
        :firstname => "Firstname",
        :lastname => "Lastname",
        :user => nil
      )
    ])
  end

  it "renders a list of credit_cards" do
    render
    assert_select "tr>td", :text => "Number".to_s, :count => 2
    assert_select "tr>td", :text => "Cvv".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Firstname".to_s, :count => 2
    assert_select "tr>td", :text => "Lastname".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
