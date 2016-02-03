class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :firstname, null: false
      t.string :lastname, null: false
      t.text :biography

      t.timestamps null: false
    end
    add_index :authors, [:firstname, :lastname]
  end
end
