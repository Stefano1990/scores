class AddStartsToDriverStandings < ActiveRecord::Migration
  def change
    add_column :driver_standings, :starts, :integer, default: 0
  end
end
