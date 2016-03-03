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
    @order = create(:order, state: 'in_progress', user: @user)
    expect(@user.current_order).to eql @order
  end
  it '.default_address' do
    @user = create(:user)
    create_list(:address, 3, user: @user)
    @default_address = create(:address, user: @user, default: true)
    create_list(:address, 3, user: @user)
    expect(@user.default_address).to eql @default_address
  end
  context '.recent_orders' do
    before do
      @user = create(:user)
      @orders = create_list(:order, 10, user: @user)
      @recent_orders = @orders.reverse
    end
    it 'without parametrs' do
      expect(@user.recent_orders).to eq(@recent_orders)
    end
    it 'with parametr' do
      @recent_orders.pop(4)
      expect(@user.recent_orders(6)).to eq(@recent_orders)
    end
  end
  
  context '.current_order' do
    before do
      @user = create(:user)
    end
    it 'no orders' do
      expect(@user.current_order).to be_nil
    end
    it 'no orders in_progress' do
      Order.aasm.states.map(&:name).each { |state|
        create_list(:order, 2, user: @user, state: state) unless state == :in_progress
      }
      expect(@user.current_order).to be_nil
    end
    it 'some orders in_progress' do
      Order.aasm.states.map(&:name).each { |state|
        create_list(:order, 2, user: @user, state: state)
      }
      expect(@user.current_order).to eql(@user.orders.where(state: "in_progress").last)
    end
  end
  
  context '.from_omniauth' do
    before do
      @user = build(:user)
      @auth = OmniAuth::AuthHash.new({
        :provider => 'facebook',
        :uid => '1234567',
        :info => {
          :email => @user.email,
          :name => @user.firstname,
        },
        :credentials => {
          :token => 'mock_token',
          :secret => 'mock_secret'
        },
        :extra => {
          :raw_info => {
            :id => '1234567',
            :email => @user.email,
            :name => @user.firstname,
          }
        }
      })
    end 
    it 'user not exist' do
      expect(User.from_omniauth(@auth)).to be_new_record
    end
    it 'user exist by uid' do
      @user.provider = @auth.provider
      @user.uid = @auth.uid
      @user.save
      expect(User.from_omniauth(@auth)).to eql(@user)
    end
    it 'user exist by email' do
      @user.save
      expect(User.from_omniauth(@auth)).to eql(@user)
    end
    it 'user not exist, auth with firstname' do
      @auth.info[:first_name] = @user.firstname
      @auth.info[:last_name] = @user.lastname
      user_auth = User.from_omniauth(@auth)
      expect(user_auth.firstname).to eql(@user.firstname)
      expect(user_auth.lastname).to eql(@user.lastname)
    end
  end
  
  context '.new_with_session' do
    before do
      @user = build(:user)
      @session = {}
      @session["devise.facebook_data"] = OmniAuth::AuthHash.new({
        :provider => 'facebook',
        :uid => '1234567',
        :info => {
          :email => @user.email,
          :name => @user.firstname,
        },
        :credentials => {
          :token => 'mock_token',
          :secret => 'mock_secret'
        },
        :extra => {
          :raw_info => {
            :id => '1234567',
            :email => @user.email,
            :name => @user.firstname,
          }
        }
      })
    end
    it '222' do
      byebug
      User.new_with_session({}, session)
    end
  end

  context '.orders_by_status' do
    before do
      @user = create(:user)
    end
    it 'empty list' do
      orders = @user.orders_by_status
      Order.aasm.states.map(&:name).each do |status|
        expect(orders[status].count).to eql(0)
      end
    end
    it 'empty list' do
      Order.aasm.states.map(&:name).each { |state|
        create_list(:order, 2, user: @user, state: state)
      }
      orders = @user.orders_by_status
      Order.aasm.states.map(&:name).each do |status|
        expect(orders[status].count).to eql(2)
      end
    end
  end
  
  it '.to_s' do
    @user = create(:user)
    expect(@user.to_s).to eql("#{@user.firstname} #{@user.lastname}")
  end

end
