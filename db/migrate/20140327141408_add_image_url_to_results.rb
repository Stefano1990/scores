class AddImageUrlToResults < ActiveRecord::Migration
  def change
    add_column :results, :image_public_url, :string
  end
end
