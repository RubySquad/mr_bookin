require 'rails_helper'
require 'features/features_spec_helper'
include Warden::Test::Helpers

feature "Signing up" do
  scenario "Visitor registers successfully via register form" do
    user = build(:user)
    visit '/users/sign_up'
    within '#new_user' do
      fill_in 'user_firstname', with: user.firstname
      fill_in 'user_lastname', with: user.lastname
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      fill_in 'user_password_confirmation', with: user.password
      click_button('Sign up')
    end
    expect(page).not_to have_content 'Sign up'
    expect(page).to have_content 'Account'
    expect(page).to have_content 'Sign out'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end 
end

feature 'Signing in' do
  background do
    @user = create(:user)
  end
  
  scenario "Signing in with correct credentials" do
    visit '/users/sign_in'
    within("#new_user") do
      fill_in 'user_email', :with => @user.email
      fill_in 'user_password', :with => @user.password
    end
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully'
  end

  scenario "Signing in as another user" do
    visit '/users/sign_in'
    within("#new_user") do
      fill_in 'user_email', :with => @user.email
      fill_in 'user_password', :with => '1234'
    end
    click_button 'Log in'
    expect(page).to have_content 'Invalid email or password'
  end
  
end

feature 'Signing out' do
  background do
    @user = create(:user)
    login_as(@user)
  end
  
  scenario "Signing out" do
    visit root_path
    click_link 'Sign out'
    expect(page).to have_content 'Signed out successfully.'
  end

end