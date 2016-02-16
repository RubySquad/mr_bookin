class CreateShippings < ActiveRecord::Migration
  def change
    create_table :shippings do |t|
      t.string :name, null: false
      t.decimal :price, precision: 6, scale: 2, null: false

      t.timestamps null: false
    end
  end
end
