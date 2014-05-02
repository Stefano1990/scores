class AddDefaultValuesToDriverResults < ActiveRecord::Migration
  def change
    change_column_default :driver_results, :laps_led, 0
    change_column_default :driver_results, :laps_comp, 0
    change_column_default :driver_results, :inc, 0
    change_column_default :driver_results, :league_points, 0
    change_column_default :driver_results, :bns_pts, 0
    change_column_default :driver_results, :race_pts, 0
  end
end
