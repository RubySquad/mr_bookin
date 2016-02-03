class Author < ActiveRecord::Base

  validates :firstname, presence: true
  validates :lastname, presence: true

  has_many :books

end
