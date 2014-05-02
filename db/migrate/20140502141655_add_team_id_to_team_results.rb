class AddTeamIdToTeamResults < ActiveRecord::Migration
  def change
    add_column :team_results, :team_id, :integer
  end
end
