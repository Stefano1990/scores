class AddUrlToStandings < ActiveRecord::Migration
  def change
    add_column :standings, :url, :string
  end
end
