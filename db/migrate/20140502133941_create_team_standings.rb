class CreateTeamStandings < ActiveRecord::Migration
  def change
    create_table :team_standings do |t|
      t.integer :standing_id
      t.integer :team_id
      t.integer :tot_pts
      t.integer :race_pts
      t.integer :bns_pts
      t.integer :laps_comp
      t.integer :laps_led
      t.integer :inc
      t.integer :pos
      t.integer :penalty_pts

      t.timestamps
    end
  end
end
