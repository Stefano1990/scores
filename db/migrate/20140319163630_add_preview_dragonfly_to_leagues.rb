class AddPreviewDragonflyToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :preview_uid, :string
    add_column :leagues, :preview_name, :string
  end
end
