require 'rails_helper'
require 'features/features_spec_helper'
include Warden::Test::Helpers

feature 'Admin have access to admin panel' do
  background do
    @admin = create(:admin)
    login_as(@admin)
  end
  
  scenario 'by path' do
    visit '/admin'
    expect(page).to have_content 'Site Administration'
  end
  scenario 'by link' do
    visit '/'
    click_link 'Admin'
    expect(page).to have_content 'Site Administration'
  end

end
