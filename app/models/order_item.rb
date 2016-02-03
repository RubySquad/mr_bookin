class OrderItem < ActiveRecord::Base

  belongs_to :order
  belongs_to :book

  validates :price, presence: true
  validates :quantity, presence: true

end
