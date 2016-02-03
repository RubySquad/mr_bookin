require 'rails_helper'

RSpec.describe "addresses/index", type: :view do
  before(:each) do
    assign(:addresses, [
      Address.create!(
        :address => "Address",
        :zipcode => "Zipcode",
        :city => "City",
        :phone => "Phone",
        :country => nil
      ),
      Address.create!(
        :address => "Address",
        :zipcode => "Zipcode",
        :city => "City",
        :phone => "Phone",
        :country => nil
      )
    ])
  end

  it "renders a list of addresses" do
    render
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "Zipcode".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
