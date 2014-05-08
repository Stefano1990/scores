class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :season_id, allow_nil: false, foreign_key: true

      t.timestamps
    end
  end
end
