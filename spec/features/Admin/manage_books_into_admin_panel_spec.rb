require 'rails_helper'
require 'features/features_spec_helper'
include Warden::Test::Helpers

feature 'Admin able to manage (create/read/update/delete) books into admin panel' do
  background do
    @book = create(:book)
    @admin = create(:admin)
    login_as(@admin)
    @book_path = "/admin/book/#{@book.id}"
  end
  
  scenario 'read' do
    visit @book_path
    expect(page).to have_content "Details for Book '#{@book.title}'"
  end
  
  scenario 'update' do
    visit @book_path + '/edit'
    click_button 'Save'
    expect(page).to have_content 'Book successfully updated'
  end

  scenario 'delete' do
    visit @book_path + '/delete'
    click_button "Yes, I'm sure"
    expect(page).to have_content 'Book successfully deleted'
  end

  scenario 'create' do
    book = build(:book)
    visit '/admin/book/new'
    within '#new_book' do
      fill_in 'book_title', with: book.title
      click_button 'Save'
    end
    expect(page).to have_content 'Book successfully created '
  end

end
