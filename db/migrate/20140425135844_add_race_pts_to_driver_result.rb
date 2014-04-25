class AddRacePtsToDriverResult < ActiveRecord::Migration
  def change
    add_column :driver_results, :race_pts, :integer
  end
end
