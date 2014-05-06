class AddBnsPtsToPointSystem < ActiveRecord::Migration
  def change
    add_column  :point_systems, :pole_position, :integer, default: 0
    add_column  :point_systems, :fastest_lap, :integer, default: 0
    add_column  :point_systems, :lap_led, :integer, default: 0
  end
end
