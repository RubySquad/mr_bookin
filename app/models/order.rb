require 'aasm'
class Order < ActiveRecord::Base
  include AASM
  
  # STATUSES = ['canceled','in progress','in queue','in delivery','delivered']
  
  belongs_to :user
  belongs_to :credit_card
  has_many :order_items, dependent: :destroy
  has_one :order_shipping
  has_one :shipping, through: :order_shipping
  # belongs_to :billing_address, class_name: 'Address'
  # belongs_to :shipping_address, class_name: 'Address'

  validates :total_price, presence: true
  # validates :completed_date, presence: true
  validates :state, presence: true
  validates :billing_address, presence: true
  validates :shipping_address, presence: true


  aasm :column => :state do
    state :in_progress, :initial => true
    state :in_queue
    state :in_delivery
    state :delivered
    state :canceled

    event :process do
      transitions :from => :in_progress, :to => :in_queue
    end
    
    event :deliver do
      transitions :from => :in_queue, :to => :in_delivery
    end
    
    event :done, :success => :record_date do
      transitions :from => :in_delivery, :to => :delivered
    end

    event :cancel, :success => :record_date do
      transitions :from => [:in_progress, :in_queue, :in_delivery], :to => :canceled
    end
  end

  def record_date
    self.completed_date = DateTime.now
  end
    

  # def cancel!
  #   # byebug
  #   return unless can_modify?
  #   self.state = STATUSES[0]
  #   self.completed_date = DateTime.now
  # end
  
  # def next_state!
  #   return unless can_modify?
  #   current_state_index = STATUSES.index(state)
  #   self.state = STATUSES[current_state_index+1]
  #   self.completed_date = DateTime.now if self.state == STATUSES.last
  # end
  
  def can_modify?
    # completed_date.blank? && state != STATUSES.first && state != STATUSES.last
    in_progress?
  end
  
  def add_item(book, quantity=1)
    # byebug
    book = Book.find(book) unless book.is_a? Book
    return unless can_modify?
    
    item = order_items.where(book: book)
    if item.blank?
      item = self.order_items.new
      item.book = book
      item.price = book.price
      item.quantity = quantity
    else
      item = item.first
      item.quantity += quantity
    end
    item.save
  end
  
  def calculate_total
    # byebug
    return unless can_modify?
    self.total_price = order_items.sum('quantity * price')
  end
  
  def empty!
    order_items.destroy_all
  end
  
  def empty?
    order_items.count == 0
  end
  
  def to_s
    "##{id}"
  end
end
