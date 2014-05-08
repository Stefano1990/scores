class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :schedule_id, allow_nil: false, foreign_key: true
      t.integer :track_id, allow_nil: false, foreign_key: true
      t.datetime :start

      t.timestamps
    end
  end
end
