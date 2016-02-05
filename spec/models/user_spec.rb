require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  
  required_fields = %w(email firstname lastname role_id)

  include_examples 'test fields', required_fields, []
  
  it {should have_db_column(:encrypted_password)}
  it {should respond_to(:password)}

  # it {should validate_uniqueness_of(:email)}
  it {should have_many(:orders)}
  it {should have_many(:ratings)}
  it {should belong_to(:role)}
  it 'user should be able to create a new order' do
    expect(build(:user).orders).to respond_to :new
  end
  it 'user should be able to return a current order in progress' do
    @user = create(:user)
    @order = create(:order, state: Order::STATUSES[1], user: @user)
    expect(@user.current_order).to eql @order
  end
  it '.default_address'
end
