class CreateDriverTeamConnections < ActiveRecord::Migration
  def change
    create_table :driver_team_connections do |t|
      t.integer :driver_id
      t.integer :team_id

      t.timestamps
    end
  end
end
