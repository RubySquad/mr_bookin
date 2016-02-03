require 'rails_helper'

RSpec.describe "addresses/edit", type: :view do
  before(:each) do
    @address = assign(:address, Address.create!(
      :address => "MyString",
      :zipcode => "MyString",
      :city => "MyString",
      :phone => "MyString",
      :country => nil
    ))
  end

  it "renders the edit address form" do
    render

    assert_select "form[action=?][method=?]", address_path(@address), "post" do

      assert_select "input#address_address[name=?]", "address[address]"

      assert_select "input#address_zipcode[name=?]", "address[zipcode]"

      assert_select "input#address_city[name=?]", "address[city]"

      assert_select "input#address_phone[name=?]", "address[phone]"

      assert_select "input#address_country_id[name=?]", "address[country_id]"
    end
  end
end
