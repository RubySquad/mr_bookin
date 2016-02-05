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
      addr.save
    end
    self.default = ActiveRecord::Type::Boolean.new.type_cast_from_user(true)
    self.save
  end
  
  def to_s
   addr = "#{address},\n"
   addr << "#{city},\n"  
   addr << "#{country.name}\n"
   addr << "#{zipcode}\n"
   addr << "phone: #{phone}"
  end
  
  def self.from_string(string)
    address_array = string.split(/\n+/)
    new_address = Address.new
    new_address.address = address_array[0].chop
    new_address.city = address_array[1].chop
    new_address.country = Country.find_by_name(address_array[2])
    new_address.zipcode = address_array[3]
    new_address.phone = address_array[4][7..-1]
    new_address
  end
end
