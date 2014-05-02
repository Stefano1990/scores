class AddTeamIdToDriverResult < ActiveRecord::Migration
  def change
    add_column :driver_results, :team_id, :integer
  end
end
