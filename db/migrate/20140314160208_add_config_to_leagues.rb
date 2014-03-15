class AddConfigToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :config_uid, :string
    add_column :leagues, :config_name, :string
  end
end
