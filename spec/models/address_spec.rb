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
  
  it '.to_s' do
    @address = create(:address)
    test_string = "#{@address.address},\n"
    test_string << "#{@address.city},\n"  
    test_string << "#{@address.country.name}\n"
    test_string << "#{@address.zipcode}\n"
    test_string << "phone: #{@address.phone}"
    expect(@address.to_s).to eql(test_string)
  end

  it '.from_string' do
    @address = create(:address)
    test_string = @address.to_s
    test_address = Address.from_string(test_string)
    required_fields.each do |field|
      expect(test_address[field]).to eq(@address[field])
    end
  end 
end
