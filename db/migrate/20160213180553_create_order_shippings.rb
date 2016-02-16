class CreateOrderShippings < ActiveRecord::Migration
  def change
    create_table :order_shippings do |t|
      t.belongs_to :order, index: true, foreign_key: true
      t.belongs_to :shipping, index: true, foreign_key: true
      t.decimal :price, precision: 6, scale: 2, null: false

      t.timestamps null: false
    end
  end
end
