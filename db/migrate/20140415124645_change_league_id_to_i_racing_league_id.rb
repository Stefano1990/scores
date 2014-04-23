class ChangeLeagueIdToIRacingLeagueId < ActiveRecord::Migration
  def change
    rename_column :results, :league_id, :iracing_league_id
  end
end
