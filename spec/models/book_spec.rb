require 'rails_helper'

RSpec.describe Book, type: :model do
  required_fields = %w(title price stock)
  other_fields = %w(description)

  include_examples 'test fields', required_fields, other_fields

  it {should belong_to(:author)}
  it {should belong_to(:category)}
  it {should have_many(:ratings)}
end
