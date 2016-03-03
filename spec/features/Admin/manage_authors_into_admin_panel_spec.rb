require 'rails_helper'
require 'features/features_spec_helper'
include Warden::Test::Helpers

feature 'Admin able to manage (create/read/update/delete) authors into admin panel' do
  background do
    @author = create(:author)
    @admin = create(:admin)
    login_as(@admin)
    @author_path = "/admin/author/#{@author.id}"
  end
  
  scenario 'read' do
    visit @author_path
    expect(page).to have_content "Details for Author 'Author ##{@author.id}'"
  end
  
  scenario 'update' do
    visit @author_path + '/edit'
    click_button 'Save'
    expect(page).to have_content 'Author successfully updated'
  end

  scenario 'delete' do
    visit @author_path + '/delete'
    click_button "Yes, I'm sure"
    expect(page).to have_content 'Author successfully deleted'
  end

  scenario 'create' do
    author = build(:author)
    visit '/admin/author/new'
    within '#new_author' do
      fill_in 'author_firstname', with: author.firstname
      fill_in 'author_lastname', with: author.lastname
      click_button 'Save'
    end
    expect(page).to have_content 'Author successfully created '
  end

end
