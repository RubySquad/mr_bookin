class CreditCard < ActiveRecord::Base
  belongs_to :user
  has_many :orders

  validates :number, presence: true
  validates :cvv, presence: true
  validates :exp_month, presence: true
  validates :exp_year, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true

end
