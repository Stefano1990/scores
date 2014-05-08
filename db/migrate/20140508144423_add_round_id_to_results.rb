class AddRoundIdToResults < ActiveRecord::Migration
  def change
    add_column :results, :round_id, :integer
    remove_column :results, :track
  end
end
