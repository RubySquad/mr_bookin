json.array!(@books) do |book|
  json.extract! book, :id, :title, :description, :price, :stock, :author_id, :category_id
  json.url book_url(book, format: :json)
end
