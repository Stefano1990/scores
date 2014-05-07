class AddSeasonIdToStandings < ActiveRecord::Migration
  def change
    add_column :standings, :season_id, :integer, allow_nil: false, foreign_key: true
  end
end
