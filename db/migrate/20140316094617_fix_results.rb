class FixResults < ActiveRecord::Migration
  def change
    remove_columns :results, :background_name, :background_uid, :image_name, :image_uid, :composite_name,
                             :composite_uid
    add_column      :results, :image_name, :string
    add_column      :results, :image_uid, :string
    add_column      :results, :url, :string
  end
end
