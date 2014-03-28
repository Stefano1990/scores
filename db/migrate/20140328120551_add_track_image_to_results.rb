class AddTrackImageToResults < ActiveRecord::Migration
  def change
    add_column :results, :track_image_url, :string
  end
end
