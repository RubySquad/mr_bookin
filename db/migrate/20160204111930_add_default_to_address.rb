class AddDefaultToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :default, :boolean, default: false, null: false
  end
end
