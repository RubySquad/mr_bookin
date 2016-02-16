require 'rails_helper'

RSpec.describe Book, type: :model do
  required_fields = %w(title price stock)
  other_fields = %w(description)

  include_examples 'test fields', required_fields, other_fields

  it {should belong_to(:author)}
  it {should belong_to(:category)}
  it {should have_many(:ratings)}
  
  context '.bestsellers' do
    before do
      @books =  create_list(:book, 10,  category: nil)
      curr_quantity = 100 * rand(100)
      @books.each do |book|
        create(:order_item, book: book, quantity: curr_quantity)
        curr_quantity /= 2
      end
    end
    it 'without count' do
      expect(Book.bestsellers).to eq(@books)
    end
    it 'with count' do
      @books.pop(5)
      expect(Book.bestsellers(5)).to eq(@books)
    end
    it 'one book in several order_items' do
      @best_book = @books.last
      create_list(:order_item, 10, book: @best_book, quantity: 1000)
      @books.insert(0, @best_book)
      @books.pop
      expect(Book.bestsellers).to eq(@books)
    end
  end
  
  context '.by_category' do
    it 'one category' do
      @category = create(:category, title: 'one category')
      @books = create_list(:book, 5, category: @category)
      books_bc = Book.by_category(@category).to_a
      expect(books_bc).to eq(@books)
    end
    it 'several categories' do
      @category = create(:category, title: 'several categories')
      @books = create_list(:book, 5, category: @category)
      @categories = create_list(:category, 5)
      @categories.each do |category|
        create_list(:book, 2,  category: category)
      end
      books_bc = Book.by_category(@category).to_a
      expect(books_bc).to eq(@books)
    end
    it 'no books in category' do
      @category = create(:category, title: 'no books in category')
      @other_category = create(:category, title: 'other_category')
      create_list(:book, 5,  category: @other_category)
      books_bc = Book.by_category(@category).to_a
      expect(books_bc).to be_empty
    end
  end
end
