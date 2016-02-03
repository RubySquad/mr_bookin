require 'rails_helper'

RSpec.describe "ratings/new", type: :view do
  before(:each) do
    assign(:rating, Rating.new(
      :review => "MyText",
      :rating => 1,
      :user => nil,
      :book => nil
    ))
  end

  it "renders new rating form" do
    render

    assert_select "form[action=?][method=?]", ratings_path, "post" do

      assert_select "textarea#rating_review[name=?]", "rating[review]"

      assert_select "input#rating_rating[name=?]", "rating[rating]"

      assert_select "input#rating_user_id[name=?]", "rating[user_id]"

      assert_select "input#rating_book_id[name=?]", "rating[book_id]"
    end
  end
end
