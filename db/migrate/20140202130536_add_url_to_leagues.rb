class AddUrlToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :url, :string
  end
end
