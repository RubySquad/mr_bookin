require 'rails_helper'

RSpec.describe "ratings/index", type: :view do
  before(:each) do
    assign(:ratings, [
      Rating.create!(
        :review => "MyText",
        :rating => 1,
        :user => nil,
        :book => nil
      ),
      Rating.create!(
        :review => "MyText",
        :rating => 1,
        :user => nil,
        :book => nil
      )
    ])
  end

  it "renders a list of ratings" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
