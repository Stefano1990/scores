class ChangeReferencesInStandingsAndResults < ActiveRecord::Migration
  def up
    rename_column :standings, :league_id, :graphic_id
    rename_column :results, :league_id, :graphic_id
  end

  def down
    rename_column :standings, :graphic_id, :league_id
    rename_column :results, :graphic_id, :league_id
  end
end
