class ChangeResults < ActiveRecord::Migration
  def change
    remove_column :results, :graphic_id
    remove_column :results, :image_name
    remove_column :results, :image_uid
    remove_column :results, :image_public_url
    remove_column :results, :first_entry
    remove_column :results, :last_entry
    remove_column :results, :track_image_url
    remove_column :results, :url
    add_column :results, :start_time,           :datetime
    add_column :results, :track,                :string
    add_column :results, :series,               :string
    add_column :results, :hosted_session_name,  :string
    add_column :results, :league_name,          :string
    add_column :results, :league_id,            :integer
    add_column :results, :league_season,        :string
    add_column :results, :league_season_id,     :integer
    add_column :results, :points_system,        :string
  end
end
