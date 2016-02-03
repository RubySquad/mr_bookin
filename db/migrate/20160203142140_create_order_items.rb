class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.decimal :price, precision: 6, scale: 2, default: 0.00, null: false
      t.integer :quantity, default: 1, null: false
      t.belongs_to :order, index: true, foreign_key: true
      t.belongs_to :book, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
