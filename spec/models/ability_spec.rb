require 'rails_helper'
require "cancan/matchers"

RSpec.describe Ability, type: :model do
  subject(:ability){ Ability.new(user) }
  let(:user){ create(:user, role: role) }
  let(:other_user) {create(:user)}
  let(:order) {create(:order, user: user)}
  let(:other_order) {create(:order, user: other_user)}
  let(:rating_not_approved) {create(:rating, approved: false)}
  
  describe 'as guest' do
    let(:user){ nil }

    [Book, Category, Author, Rating].each { |model|
      it {should be_able_to(:read, model)}
    }
    it {should be_able_to(:bestsellers, Book)}
    [:show_cart, :add_to_cart, :add_item, :clear_cart].each { |action|
      it {should be_able_to(action, order, user: user)}
      it {should_not be_able_to(action, other_order, user: other_user.to_s)}
    }
    it {should be_able_to(:destroy, OrderItem.new(order: order), order: { user: user })}
    it {should_not be_able_to(:destroy, OrderItem.new(order: other_order), order: { user: other_user.to_s })}
    it {should_not be_able_to(:read, rating_not_approved, approved: false)}
  end
  describe 'as customer' do
    let(:role) { Role.find_or_create_by(name: "Customer") }
    
    it {should be_able_to(:read, order, user: user.to_s)}
    it {should_not be_able_to(:read, other_order, user: other_user.to_s)}
    it {should be_able_to(:create, Rating)}
    it {should be_able_to(:update, order, user: user.to_s)}
    it {should_not be_able_to(:update, other_order, user: other_user.to_s)}
    it {should_not be_able_to(:read, rating_not_approved, approved: false)}
  end
  describe 'as manager' do
    let(:role) { Role.find_or_create_by(name: "Manager") }
    
    [Book, Category, Author, Country, Order, OrderItem].each { |model|
      it {should be_able_to(:crud, model)}
    }
    it {should be_able_to(:update, User)}
    it {should_not be_able_to(:destroy, Order)}
  end
  describe 'as admin' do
    let(:role) { Role.find_or_create_by(name: "Admin") }
    
    it {should be_able_to(:manage, :all)}
  end
end
