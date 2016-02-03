require 'rails_helper'

RSpec.describe "ratings/edit", type: :view do
  before(:each) do
    @rating = assign(:rating, Rating.create!(
      :review => "MyText",
      :rating => 1,
      :user => nil,
      :book => nil
    ))
  end

  it "renders the edit rating form" do
    render

    assert_select "form[action=?][method=?]", rating_path(@rating), "post" do

      assert_select "textarea#rating_review[name=?]", "rating[review]"

      assert_select "input#rating_rating[name=?]", "rating[rating]"

      assert_select "input#rating_user_id[name=?]", "rating[user_id]"

      assert_select "input#rating_book_id[name=?]", "rating[book_id]"
    end
  end
end
