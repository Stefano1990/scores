class AddThirtySecToPenalties < ActiveRecord::Migration
  def change
    add_column :penalties, :thirty_sec, :boolean
  end
end
