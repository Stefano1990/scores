class AddStartsToTeamStandings < ActiveRecord::Migration
  def change
    add_column :team_standings, :starts, :integer, default: 0
  end
end
