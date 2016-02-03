json.array!(@orders) do |order|
  json.extract! order, :id, :state, :completed_date, :total_price, :user_id, :credit_card_id, :shipping_address, :billing_address
  json.url order_url(order, format: :json)
end
