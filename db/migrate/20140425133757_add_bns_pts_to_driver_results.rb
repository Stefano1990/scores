class AddBnsPtsToDriverResults < ActiveRecord::Migration
  def change
    add_column :driver_results, :bns_pts, :integer
  end
end
