class Order < ActiveRecord::Base

  STATUSES = ['canceled','in progress','in queue','in delivery','delivered']
  
  belongs_to :user
  belongs_to :credit_card
  has_many :order_items
  # belongs_to :billing_address, class_name: 'Address'
  # belongs_to :shipping_address, class_name: 'Address'

  validates :total_price, presence: true
  # validates :completed_date, presence: true
  validates :state, presence: true
  validates :billing_address, presence: true
  validates :shipping_address, presence: true

  def cancel!
    # byebug
    return unless can_modify?
    self.state = STATUSES[0];
    self.completed_date = DateTime.now;
  end
  
  def next_state!
    return unless can_modify?
    current_state_index = STATUSES.index(state)
    self.state = STATUSES[current_state_index+1]
    self.completed_date = DateTime.now if self.state == STATUSES.last
  end
  
  def can_modify?
    completed_date.blank? && state != STATUSES.first && state != STATUSES.last
  end
  
  def add_item(book)
    # byebug
    return unless can_modify?
    item = order_items.where(book: book)
    if item.blank?
      item = self.order_items.new
      item.book = book
      item.price = book.price
    else
      item = item.first
      item.quantity += 1
    end
    item.save
  end
  
  def calculate_total
    return unless can_modify?
    self.total_price = order_items.sum('quantity * price')
  end
  
  def empty!
    order_items.destroy_all
  end
  
  def empty?
    order_items.count == 0
  end
end
