class Shipping < ActiveRecord::Base
  has_many :order_shippings
  has_many :orders, through: :order_shippings
end
