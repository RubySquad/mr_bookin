class User < ActiveRecord::Base

  devise :omniauthable, :omniauth_providers => [:facebook]
  
  belongs_to :role
  has_many :orders
  has_many :ratings
  has_many :addresses
  
  validates :email, presence: true
  # validates :password, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :role_id, presence: true
  
  before_validation :set_default_role
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  def current_order
    orders.where(state: "in_progress").last
  end
  
  def default_address
    addresses.where(default: true).first
  end
  
  def recent_orders(count=nil)
    orders.order(id: :desc).limit(count)
  end
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      if auth.info.first_name.blank?
        user.firstname = auth.info.name
      else
        user.firstname = auth.info.first_name
        user.lastname = auth.info.last_name
      end
      user.provider = auth.provider
      user.uid = auth.uid
    end
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
        if data["first_name"].blank?
          user.firstname = data["name"] if user.firstname.blank?
        else
          user.firstname = data["first_name"] if user.firstname.blank?
          user.lastname = data["last_name"] if user.lastname.blank?
        end
        user.provider = session["devise.facebook_data"]["provider"]
        user.uid = session["devise.facebook_data"]["uid"]
      end
    end
  end
  
  def to_s
    "#{firstname} #{lastname}"
  end
  
  def orders_by_status
    orders = {}
    Order::STATUSES.each do |status|
      orders[status] = Order.where(state: status, user_id: id)
    end
    orders
  end

private
  def set_default_role
    self.role ||= Role.find_by_name('Customer')
  end

end
