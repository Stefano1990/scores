class CreateSeries < ActiveRecord::Migration
  def change
    create_table :series do |t|
      t.integer :league_id
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
