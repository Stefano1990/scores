class RenameLeagueToGraphic < ActiveRecord::Migration
  def up
    rename_table :leagues, :graphics
  end

  def down
    rename_table :graphics, :leagues
  end
end
