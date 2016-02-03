class Order < ActiveRecord::Base

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

end
