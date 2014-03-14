class CreateStandingConfigs < ActiveRecord::Migration
  def change
    create_table :standing_configs do |t|
      t.integer :standing_id
      t.string :config_name
      t.string :config_uid

      t.timestamps
    end
  end
end
