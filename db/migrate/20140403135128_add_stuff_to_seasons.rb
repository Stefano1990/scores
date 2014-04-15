class AddStuffToSeasons < ActiveRecord::Migration
  def change
    add_column  :seasons, :background_uid, :string
    add_column  :seasons, :background_name, :string
    add_column  :seasons, :preview_uid, :string
    add_column  :seasons, :preview_name, :string
    add_column  :seasons, :config, :text
  end
end
