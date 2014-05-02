class CreateTeamResults < ActiveRecord::Migration
  def change
    create_table :team_results do |t|
      t.integer :result_id
      t.integer :laps_led
      t.integer :laps_comp
      t.integer :inc
      t.integer :league_points
      t.integer :race_pts
      t.integer :bns_pts

      t.timestamps
    end
  end
end
