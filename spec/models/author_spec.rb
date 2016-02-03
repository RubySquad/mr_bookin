require 'rails_helper'

RSpec.describe Author, type: :model do
  required_fields = %w(firstname lastname)
  other_fields = %w(biography)

  include_examples 'test fields', required_fields, other_fields

  it {should have_many(:books)}
end
