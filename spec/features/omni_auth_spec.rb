require 'rails_helper'
require 'features/features_spec_helper'

OmniAuth.config.test_mode = true

feature "Facebook" do
  before do 
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      :provider => 'facebook',
      :uid => '1234567',
      :info => {
        :email => 'mock@user.com',
        :name => 'mockuser',
      },
      :credentials => {
        :token => 'mock_token',
        :secret => 'mock_secret'
      },
      :extra => {
        :raw_info => {
          :id => '1234567',
          :email => 'mock@user.com',
          :name => 'mockuser',
        }
      }
    })
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user] # If using Devise
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook] 
    create(:role)
  end 
  it 'sign in new user with Facebook account' do
    password = Faker::Internet.password
    visit '/'
    expect(page).to have_content('Sign in with Facebook')
    click_link 'Sign in with Facebook'
    expect(page.find('input#user_firstname').value).to eq('mockuser')
    expect(page.find('input#user_email').value).to eq('mock@user.com')
    fill_in 'user_lastname', with: 'mockuser'
    fill_in 'user_password', with: password
    fill_in 'user_password_confirmation', with: password
    click_button('Sign up')
    expect(page).not_to have_content 'Sign in with Facebook'
    expect(page).to have_content 'Account'
    expect(page).to have_content 'Sign out'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  it "can sign in user with Facebook account" do
    create(:user, provider: 'facebook', uid: '1234567')
    visit '/'
    expect(page).to have_content("Sign in with Facebook")
    click_link "Sign in with Facebook"
    expect(page).to have_content 'Sign out'
    expect(page).to have_content 'Account'
    expect(page).to have_content 'Successfully authenticated from Facebook account.'
  end

  it "can handle authentication error" do
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
    visit '/'
    expect(page).to have_content("Sign in with Facebook")
    click_link "Sign in with Facebook"
    expect(page).to have_content("Sign in with Facebook")
    expect(page).to have_content('Authentication failed.')
  end

end
