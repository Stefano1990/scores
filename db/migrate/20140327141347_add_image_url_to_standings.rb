class AddImageUrlToStandings < ActiveRecord::Migration
  def change
    add_column :standings, :image_public_url, :string
  end
end
