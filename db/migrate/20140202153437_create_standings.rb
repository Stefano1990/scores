class CreateStandings < ActiveRecord::Migration
  def change
    create_table :standings do |t|
      t.integer :league_id
      t.string :background_uid
      t.string :background_name
      t.string :image_uid
      t.string :image_name

      t.timestamps
    end
  end
end
