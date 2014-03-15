class ChangeConfigsForLeagues < ActiveRecord::Migration
  def change
    remove_column     :leagues, :config_name
    remove_column     :leagues, :config_uid
    add_column        :leagues, :config, :text
  end
end
