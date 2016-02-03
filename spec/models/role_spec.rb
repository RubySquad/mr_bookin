require 'rails_helper'

RSpec.describe Role, type: :model do
  required_fields = %w(name)

  include_examples 'test fields', required_fields, []

  it {should validate_uniqueness_of(:name)}

end
