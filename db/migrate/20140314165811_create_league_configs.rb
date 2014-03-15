class CreateLeagueConfigs < ActiveRecord::Migration
  def change
    create_table :league_configs do |t|
      t.integer :league_id
      t.string :config_name
      t.string :config_uid

      t.timestamps
    end
  end
end
