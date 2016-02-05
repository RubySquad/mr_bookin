class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, presence: true
  # validates :password, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :role_id, presence: true

  has_many :orders
  has_many :ratings
  has_many :addresses
  belongs_to :role
  
  def current_order
    orders.where(state: "in progress").last
  end
  
  def default_address
    addresses.where(default: true).first
  end
  
  def recent_orders(count=nil)
    orders.order(id: :desc).limit(count)
  end

end
