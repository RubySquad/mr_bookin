require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  required_fields = %w(price quantity)

  include_examples 'test fields', required_fields, []

  it { should belong_to(:book)}
  it { should belong_to(:order)}
  
  it 'delete order_items' do
    @order = create(:order)
    @order_item = create(:order_item, order: @order)
    expect(@order).to receive(:calculate_total)
    @order_item.send(:destroy)
  end
  it 'update order_items' do
    @order = create(:order)
    @order_item = create(:order_item, order: @order)
    expect(@order).to receive(:calculate_total)
    @order_item.send(:update, {})
  end
end
