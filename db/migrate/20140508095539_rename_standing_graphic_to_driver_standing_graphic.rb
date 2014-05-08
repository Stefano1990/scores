class RenameStandingGraphicToDriverStandingGraphic < ActiveRecord::Migration
  def up
    rename_table :standing_graphics, :driver_standing_graphics
  end

  def down
    rename_table :driver_standing_graphics, :standing_graphics
  end
end
