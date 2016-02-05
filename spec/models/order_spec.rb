require 'rails_helper'

RSpec.describe Order, type: :model do

  required_fields = %w(total_price state billing_address shipping_address)
  other_fields = %w(completed_date)

  include_examples 'test fields', required_fields, other_fields

  it 'by default an order should have "in progress" state' do
    @order =  Order.new
    expect(@order.state).to eql(Order::STATUSES[1])
  end
  it { should belong_to(:user)}
  it { should belong_to(:credit_card)}
  it { should have_many(:order_items)}
  # it { should belong_to(:billing_address)}
  # it { should belong_to(:shipping_address)}
  context '.add_item' do #'an order should be able to add a book to the order'
    before do
      @order = create(:order, state: Order::STATUSES[1])
      @category =  create(:category)
      @book =  create(:book, category: @category)
      @order_item = create(:order_item, order: @order, book: @book)
      @book_new = create(:book, category: @category)
    end
    it 'add book to new order' do
      @order = create(:order, state: Order::STATUSES[1], user: @user, credit_card: @credit_card)
      expect { @order.add_item(@book) }.to change{ @order.order_items.count }.by(1)
    end
    it 'add new book to existing order' do
      expect { @order.add_item(@book_new) }.to change{ @order.order_items.count }.by(1)
    end
    it 'add existing book to existing order' do
      expect { @order.add_item(@book) }.not_to change{ @order.order_items.count }
    end
    it 'expect can_modify?' do
      expect(@order).to receive(:can_modify?)
      @order.send(:add_item, @book)
    end
    # it 'cannot add book to completed order' do
    #   @order = create(:order, state: Order::STATUSES[1], user: @user, credit_card: @credit_card)
    #   @order.completed_date = DateTime.now
    #   expect { @order.add_item(@book_new) }.not_to change{ @order.order_items.count }
    # end
    it 'raise wrong parametr error' do
      expect { @order.add_item }.to raise_error ArgumentError
    end
    it 'expect calculate_total' do
      expect(@order).to receive(:calculate_total)
      @order.add_item(@book)
    end
    it 'expect calculate_total with new book' do
      expect(@order).to receive(:calculate_total)
      @order.add_item(@book_new)
    end
  end
  context '.cancel!' do
    before do
      @order = create(:order, state: Order::STATUSES[1])
      @order.cancel!
    end
    it 'has status canceled' do
      expect(@order.state).eql? Order::STATUSES[0]
    end
    it 'has completed_date' do
      expect(@order.completed_date).to_not be_nil
    end
    it 'can not be modified' do
      expect(@order).not_to be_can_modify
    end
    it 'expect can_modify?' do
      expect(@order).to receive(:can_modify?)
      @order.send(:cancel!)
    end
  end
  context '.can_modify?' do
    it 'cant modify canceled' do
      @order = create(:order, state: Order::STATUSES.first)
      expect(@order).not_to be_can_modify
    end
    it 'cant modify delivered' do
      @order = create(:order, state: Order::STATUSES.last)
      expect(@order).not_to be_can_modify
    end
    it 'cant modify if completed_date present' do
      @order = create(:order, completed_date: Time.now)
      expect(@order).not_to be_can_modify
    end
    Order::STATUSES.each_with_index { |item, index|
      it { 
        @order = create(:order, state: item)
        expect(@order).to be_can_modify
      } unless index == 0 || item == Order::STATUSES.last
    }
  end
  context '.next_state!' do
    Order::STATUSES.each_with_index { |item, index|
      it { 
        @order = create(:order, state: item)
        @order.next_state!
        expect(@order.state).to eql(Order::STATUSES[index + 1])
      } unless index == 0 || item == Order::STATUSES.last
    }
    it 'canceled not changed' do
      @order = create(:order, state: Order::STATUSES.first)
      @order.next_state!
      expect(@order.state).to eql(Order::STATUSES.first)
    end
    it 'delivered not changed' do
      @order = create(:order, state: Order::STATUSES.last)
      @order.next_state!
      expect(@order.state).to eql(Order::STATUSES.last)
    end
    it 'changed completed_date' do
      @order = create(:order, state: Order::STATUSES[-2])
      expect { @order.next_state! }.to change{ @order.completed_date }
    end
    it 'expect can_modify?' do
      @order = Order.new
      expect(@order).to receive(:can_modify?)
      @order.send(:next_state!)
    end
  end
  context '.calculate_total' do
    before do
      @order = create(:order, state: Order::STATUSES[1])
      @category =  create(:category)
      @book =  create(:book, category: @category)
      @order_item = create(:order_item, order: @order, book: @book, price: @book.price)
    end
    # it 'total price change' do
    #   expect { @order.calculate_total }.to change{ @order.total_price }
    # end
    it 'total price = order_item.price * quantity' do
      @order.calculate_total
      expect(@order.total_price).to eql(@order_item.price * @order_item.quantity)
    end
  end
  context 'empty test' do
    before do
      @order = create(:order, state: Order::STATUSES[1])
    end
    it 'empty if no order items' do
      expect(@order).to be_empty
    end
    it 'not empty if order items present' do
      @category =  create(:category)
      @book =  create(:book, category: @category)
      @order_item = create(:order_item, order: @order, book: @book, price: @book.price)
      expect(@order).not_to be_empty
    end
    it 'clears when empty! called' do
      @category =  create(:category)
      @book =  create(:book, category: @category)
      @order_items = create_list(:order_item, 3, order: @order, book: @book, price: @book.price)
      @order.empty!
      expect(@order).to be_empty
    end
  end
  it {should respond_to(:total_price)} # 'an order should be able to return a total price of the order'
end
