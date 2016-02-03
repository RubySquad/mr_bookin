class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.string :number,   null: false
      t.string :cvv,      null: false
      t.integer :exp_month,   default: 1,  null: false
      t.integer :exp_year,    default: 16,  null: false
      t.string :firstname,    default: "", null: false
      t.string :lastname,     default: "", null: false
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :credit_cards, :number, unique: true
  end
end
