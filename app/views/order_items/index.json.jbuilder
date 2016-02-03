json.array!(@order_items) do |order_item|
  json.extract! order_item, :id, :price, :quantity, :order_id, :book_id
  json.url order_item_url(order_item, format: :json)
end
