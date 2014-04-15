class CreateDriverResults < ActiveRecord::Migration
  def change
    create_table :driver_results do |t|
      t.integer :result_id
      t.integer :driver_id
      t.integer :fin_pos
      t.integer :car_id
      t.string :car
      t.integer :car_class_id
      t.string :car_class
      t.integer :cust_id
      t.string :name
      t.integer :start_pos
      t.string :car_nr
      t.integer :out_id
      t.string :out
      t.string :interval
      t.integer :laps_led
      t.string :average_lap_time
      t.string :fastest_lap_time
      t.integer :fast_lap_nr
      t.integer :laps_comp
      t.integer :inc
      t.integer :league_points

      t.timestamps
    end
  end
end
