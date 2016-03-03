require 'rails_helper'

RSpec.describe Shipping, type: :model do
  it '.name_with_price' do
    @shipping = create(:shipping)
    expect(@shipping.name_with_price).to eql("#{@shipping.name}($#{@shipping.price})")
  end
end
