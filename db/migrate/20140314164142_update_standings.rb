class UpdateStandings < ActiveRecord::Migration
  def change
    remove_column :standings, :config_uid
    remove_column :standings, :config_name
    remove_column :standings, :composite_name
    remove_column :standings, :composite_uid
    remove_column :standings, :background_name
    remove_column :standings, :background_uid
  end
end
