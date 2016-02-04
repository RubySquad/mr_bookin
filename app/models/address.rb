class Address < ActiveRecord::Base
  belongs_to :country
  belongs_to :user
  
  validates :address, presence: true
  validates :zipcode, presence: true
  validates :city, presence: true
  validates :phone, presence: true
  validates :country_id, presence: true
  
  def default!
    current_default_user_addresses = user.addresses.where(default: ActiveRecord::Type::Boolean.new.type_cast_from_user(true))
    current_default_user_addresses.each do |addr|
      addr.default = ActiveRecord::Type::Boolean.new.type_cast_from_user(false)
      # byebug
      addr.save
    end
    self.default = ActiveRecord::Type::Boolean.new.type_cast_from_user(true)
    self.save
  end
    
end
