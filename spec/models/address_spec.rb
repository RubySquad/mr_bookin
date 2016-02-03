require 'rails_helper'

RSpec.describe Address, type: :model do
  required_fields = %w(address zipcode city phone country_id)

  include_examples 'test fields', required_fields, []

end
