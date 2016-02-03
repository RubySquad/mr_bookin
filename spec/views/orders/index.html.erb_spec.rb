require 'rails_helper'

RSpec.describe "orders/index", type: :view do
  before(:each) do
    assign(:orders, [
      Order.create!(
        :state => "State",
        :total_price => "9.99",
        :user => nil,
        :credit_card => nil,
        :shipping_address => "MyText",
        :billing_address => "MyText"
      ),
      Order.create!(
        :state => "State",
        :total_price => "9.99",
        :user => nil,
        :credit_card => nil,
        :shipping_address => "MyText",
        :billing_address => "MyText"
      )
    ])
  end

  it "renders a list of orders" do
    render
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
