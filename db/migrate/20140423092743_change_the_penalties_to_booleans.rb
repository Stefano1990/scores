class ChangeThePenaltiesToBooleans < ActiveRecord::Migration
  def change
    add_column :penalties, :one_sec, :boolean
    add_column :penalties, :two_sec, :boolean
    add_column :penalties, :three_sec, :boolean
    add_column :penalties, :five_sec, :boolean
    add_column :penalties, :ten_sec, :boolean
    add_column :penalties, :twenty_sec, :boolean
    add_column :penalties, :one_grid, :boolean
    add_column :penalties, :two_grid, :boolean
    add_column :penalties, :three_grid, :boolean
    add_column :penalties, :five_grid, :boolean
    add_column :penalties, :ten_grid, :boolean
    remove_column :penalties, :time
  end
end
