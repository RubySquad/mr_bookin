json.array!(@addresses) do |address|
  json.extract! address, :id, :address, :zipcode, :city, :phone, :country_id
  json.url address_url(address, format: :json)
end
