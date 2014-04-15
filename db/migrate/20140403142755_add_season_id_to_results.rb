class AddSeasonIdToResults < ActiveRecord::Migration
  def change
    add_column :results, :season_id, :integer
  end
end
