require 'rails_helper'

RSpec.describe Address, type: :model do
  required_fields = %w(address zipcode city phone country_id)
  other_fields = %w(default)

  include_examples 'test fields', required_fields, []

  it {should belong_to(:country)}
  it {should belong_to(:user)}
  
  context '.default!' do
    it 'set address default true' do
      @user =  FactoryGirl.create(:user)
      @addresses = FactoryGirl.create_list(:address, 3, user: @user, default: true)
      @test_address = FactoryGirl.create(:address, user: @user, default: false)
      @test_address.default!
      expect(@test_address).to be_default
      @addresses.each do |address|
        expect(address).not_to be_default
      end
    end
    it 'set address default false'
    it 'default not change'
  end
  
end
