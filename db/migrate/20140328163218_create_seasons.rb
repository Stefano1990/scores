class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.integer :series_id
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
