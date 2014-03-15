class AddBackgroundToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :background_name, :string
    add_column :leagues, :background_uid, :string
  end
end
