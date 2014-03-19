class AddStuffToDrivers < ActiveRecord::Migration
  def change
    add_column  :drivers, :race_pts, :integer
    add_column  :drivers, :interval, :string
    add_column  :drivers, :laps_led, :integer
    add_column  :drivers, :fastest_lap, :string
    add_column  :drivers, :fast_lap, :integer
    add_column  :drivers, :avg_lap, :string
    add_column  :drivers, :inc, :integer
    add_column  :drivers, :status, :string
  end
end
