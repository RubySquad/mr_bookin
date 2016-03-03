class Book < ActiveRecord::Base
  belongs_to :author
  belongs_to :category
  has_many :ratings

  validates :title, presence: true
  validates :price, presence: true
  validates :stock, presence: true
  
  has_attached_file :image, styles: { large: "600x600>", thumb: "200x200>" }, default_url: "blank_book.jpg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  
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

  def to_s
    "#{title} by #{author}"
  end
  
end
