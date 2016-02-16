class AddApprovedToRating < ActiveRecord::Migration
  def change
    add_column :ratings, :approved, :boolean, default: false, null: false
  end
end
