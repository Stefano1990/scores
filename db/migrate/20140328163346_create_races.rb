class CreateRaces < ActiveRecord::Migration
  def change
    create_table :races do |t|
      t.integer :season_id
      t.date :date
      t.string :name
      t.time :practice_start
      t.time :race_start
      t.integer :track_id
      t.integer :laps
      t.time :time
      t.integer :car_id

      t.timestamps
    end
  end
end
