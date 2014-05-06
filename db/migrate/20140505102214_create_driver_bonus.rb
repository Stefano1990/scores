class CreateDriverBonus < ActiveRecord::Migration
  def change
    create_table :driver_bonus do |t|
      t.integer :driver_result_id
      t.boolean :pole
      t.boolean :fastest_lap
      t.integer :lap_led

      t.timestamps
    end
  end
end
