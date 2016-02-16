require 'rails_helper'
require 'features/features_spec_helper'

feature 'User can see best sellers on the main page' do
  background do
    @books =  create_list(:book, 10,  category: nil)
    curr_quantity = 100 * rand(100)
    @books.each do |book|
      create(:order_item, book: book, quantity: curr_quantity)
      curr_quantity /= 2
    end
    visit root_path
    @carousel = page.find('div.carousel-inner')
  end

  scenario 'carousel have all bestsellers' do
    expect(@carousel.find_all('div.item').count).to eql(3)
  end

  scenario 'in carousel first item is active' do
    expect(@carousel.find_all('div.item').first).to eq(@carousel.find_all('div.active').last)
  end

  scenario 'in carousel first item is active' do
    # car_controls = page.find_all('a.carousel-control')
    # car_controls.
    click_link('›')
    # car_controls.last.click
    carousel = page.find('div.carousel-inner')
    # byebug
    expect(carousel.find_all('div.item')[1]).to eq(carousel.find_all('div.active').last)
  end

  scenario 'some' do
    visit root_path
    # byebug
    expect(page).to have_selector 'div#bestsellerCarousel'
  end
#   before :each do
#     User.make(:email => 'user@example.com', :password => 'password')
#   end

#   it "signs me in" do
#     visit '/sessions/new'
#     within("#session") do
#       fill_in 'Email', :with => 'user@example.com'
#       fill_in 'Password', :with => 'password'
#     end
#     click_button 'Sign in'
#     expect(page).to have_content 'Success'
#   end
end