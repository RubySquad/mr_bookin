require 'rails_helper'

RSpec.describe "orders/edit", type: :view do
  before(:each) do
    @order = assign(:order, Order.create!(
      :state => "MyString",
      :total_price => "9.99",
      :user => nil,
      :credit_card => nil,
      :shipping_address => "MyText",
      :billing_address => "MyText"
    ))
  end

  it "renders the edit order form" do
    render

    assert_select "form[action=?][method=?]", order_path(@order), "post" do

      assert_select "input#order_state[name=?]", "order[state]"

      assert_select "input#order_total_price[name=?]", "order[total_price]"

      assert_select "input#order_user_id[name=?]", "order[user_id]"

      assert_select "input#order_credit_card_id[name=?]", "order[credit_card_id]"

      assert_select "textarea#order_shipping_address[name=?]", "order[shipping_address]"

      assert_select "textarea#order_billing_address[name=?]", "order[billing_address]"
    end
  end
end
