class Category < ActiveRecord::Base

  has_many :books
  
  validates :title, presence: true, uniqueness: true

  def to_s
    "#{title}"
  end
end
