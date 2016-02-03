class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :state,    default: "in progress", null: false
      t.datetime :completed_date
      t.decimal :total_price, precision: 6, scale: 2, default: 0.00, null: false
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :credit_card, index: true, foreign_key: true
      t.text :shipping_address, null: false
      t.text :billing_address, null: false

      t.timestamps null: false
    end
  end
end
