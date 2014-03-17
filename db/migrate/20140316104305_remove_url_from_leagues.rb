class RemoveUrlFromLeagues < ActiveRecord::Migration
  def change
    remove_column :leagues, :url
  end
end
