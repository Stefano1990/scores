class AddBonusesToDriverResults < ActiveRecord::Migration
  def change
    add_column :driver_results, :fastest_lap, :boolean
    add_column :driver_results, :lap_led, :boolean
    add_column :driver_results, :pole_position, :boolean
  end
end
