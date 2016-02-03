json.array!(@ratings) do |rating|
  json.extract! rating, :id, :review, :rating, :user_id, :book_id
  json.url rating_url(rating, format: :json)
end
