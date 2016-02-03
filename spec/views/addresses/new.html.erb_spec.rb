require 'rails_helper'

RSpec.describe "addresses/new", type: :view do
  before(:each) do
    assign(:address, Address.new(
      :address => "MyString",
      :zipcode => "MyString",
      :city => "MyString",
      :phone => "MyString",
      :country => nil
    ))
  end

  it "renders new address form" do
    render

    assert_select "form[action=?][method=?]", addresses_path, "post" do

      assert_select "input#address_address[name=?]", "address[address]"

      assert_select "input#address_zipcode[name=?]", "address[zipcode]"

      assert_select "input#address_city[name=?]", "address[city]"

      assert_select "input#address_phone[name=?]", "address[phone]"

      assert_select "input#address_country_id[name=?]", "address[country_id]"
    end
  end
end
