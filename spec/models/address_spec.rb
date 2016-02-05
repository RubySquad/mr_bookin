require 'rails_helper'

RSpec.describe Address, type: :model do
  required_fields = %w(address zipcode city phone country_id)
  other_fields = %w(default)

  include_examples 'test fields', required_fields, []

  it {should belong_to(:country)}
  it {should belong_to(:user)}
  
  context '.default!' do
    it 'set address default true' do
      @user = create(:user)
      @addresses = create_list(:address, 3, user: @user, default: true)
      @test_address = create(:address, user: @user, default: false)
      @test_address.default!
      expect(@test_address).to be_default
      @user.addresses.where.not(id: @test_address.id).each do |address|
        expect(address).not_to be_default
      end
    end
  end
  
end
