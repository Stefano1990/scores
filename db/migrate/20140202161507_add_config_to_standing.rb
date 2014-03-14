class AddConfigToStanding < ActiveRecord::Migration
  def change
    add_column :standings, :config_uid, :string
    add_column :standings, :config_name, :string
  end
end
