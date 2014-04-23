class CreatePenalties < ActiveRecord::Migration
  def change
    create_table :penalties do |t|
      t.integer :driver_result_id
      t.integer :result_id
      t.time :time
      t.boolean :disqualification

      t.timestamps
    end
  end
end
