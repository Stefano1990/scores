class ChangeTimeInPenalty < ActiveRecord::Migration
  def change
    remove_column :penalties, :time
    add_column    :penalties, :time, :interval
  end
end
