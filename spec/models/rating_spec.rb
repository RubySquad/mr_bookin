require 'rails_helper'

RSpec.describe Rating, type: :model do
  
  other_fields = %w(review rating)

  include_examples 'test fields', [], other_fields
  it 'rating is number from one to ten' do
    should validate_numericality_of(:rating)
      .only_integer
      .is_greater_than_or_equal_to(1)
      .is_less_than_or_equal_to(10)
  end
  it { should belong_to(:user)}
  it { should belong_to(:book)}
end
