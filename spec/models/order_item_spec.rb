require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  required_fields = %w(price quantity)

  include_examples 'test fields', required_fields, []

  it { should belong_to(:book)}
  it { should belong_to(:order)}
 end
