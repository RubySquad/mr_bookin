class Book < ActiveRecord::Base
  belongs_to :author
  belongs_to :category
  has_many :ratings

  validates :title, presence: true
  validates :price, presence: true
  validates :stock, presence: true
  
  scope :bestsellers, lambda {|count=nil|
    OrderItem.joins(:book)
    .group(:book)
    .order('sum_quantity desc')
    .limit(count)
    .sum(:quantity).keys
  }
  
  scope :by_category, lambda {|category|
    where(category: category)
  }
#User.joins("LEFT JOIN bookmarks ON bookmarks.bookmarkable_type = 'Post' AND bookmarks.user_id = users.id")
end
