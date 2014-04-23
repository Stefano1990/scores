class MakeTimeAnIntegerInPenalties < ActiveRecord::Migration
  def change
    remove_column :penalties, :time
    add_column    :penalties, :time, :integer
  end
end
