json.array!(@credit_cards) do |credit_card|
  json.extract! credit_card, :id, :number, :cvv, :exp_month, :exp_year, :firstname, :lastname, :user_id
  json.url credit_card_url(credit_card, format: :json)
end
