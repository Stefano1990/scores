class AddStartsToTeamResults < ActiveRecord::Migration
  def change
    add_column :team_results, :starts, :integer, default: 0
  end
end
