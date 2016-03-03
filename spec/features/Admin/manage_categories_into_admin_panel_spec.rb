require 'rails_helper'
require 'features/features_spec_helper'
include Warden::Test::Helpers

feature 'Admin able to manage (create/read/update/delete) categories into admin panel' do
  background do
    @category = create(:category)
    @admin = create(:admin)
    login_as(@admin)
    @category_path = "/admin/category/#{@category.id}"
  end
  
  scenario 'read' do
    visit @category_path
    expect(page).to have_content "Details for Category '#{@category.title}'"
  end
  
  scenario 'update' do
    visit @category_path + '/edit'
    click_button 'Save'
    expect(page).to have_content 'Category successfully updated'
  end

  scenario 'delete' do
    visit @category_path + '/delete'
    click_button "Yes, I'm sure"
    expect(page).to have_content 'Category successfully deleted'
  end

  scenario 'create' do
    category = build(:category)
    visit '/admin/category/new'
    within '#new_category' do
      fill_in 'category_title', with: category.title
      click_button 'Save'
    end
    expect(page).to have_content 'Category successfully created '
  end

end
