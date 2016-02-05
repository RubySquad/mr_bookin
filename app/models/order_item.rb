class OrderItem < ActiveRecord::Base

  belongs_to :order
  belongs_to :book

  validates :price, presence: true
  validates :quantity, presence: true

  after_create :recalculate
  after_update :recalculate
  after_destroy :recalculate

  private

    def recalculate
      order.calculate_total
    end

end
