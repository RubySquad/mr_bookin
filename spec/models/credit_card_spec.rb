require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  required_fields = %w(number cvv exp_month exp_year firstname lastname)

  include_examples 'test fields', required_fields, []

  it {should belong_to(:user)}
  it {should have_many(:orders)}
end
