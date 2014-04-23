class ChangeTimeFieldsAgain < ActiveRecord::Migration
  def change
    remove_column :driver_results, :interval
    remove_column :driver_results, :fastest_lap_time
    remove_column :driver_results, :average_lap_time
    add_column    :driver_results, :interval, :interval
    add_column    :driver_results, :fastest_lap_time, :interval
    add_column    :driver_results, :average_lap_time, :interval
  end
end
