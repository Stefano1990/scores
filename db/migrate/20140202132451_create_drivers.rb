class CreateDrivers < ActiveRecord::Migration
  def change
    create_table :drivers do |t|
      t.integer :pos
      t.integer :league_id
      t.string :name
      t.string :team
      t.integer :starts
      t.integer :wins
      t.integer :top5
      t.integer :top10
      t.integer :tot_pts
      t.integer :bns_pts
      t.integer :laps
      t.integer :beh_lead
      t.integer :beh_next

      t.timestamps
    end
  end
end
