class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title,    null: false
      t.string :description
      t.decimal :price, precision: 6, scale: 2, default: 0.00, null: false
      t.integer :stock, default: 0, null: false
      t.belongs_to :author, index: true, foreign_key: true
      t.belongs_to :category, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :books, :title
  end
end
