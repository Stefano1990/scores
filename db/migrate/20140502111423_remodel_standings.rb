class RemodelStandings < ActiveRecord::Migration
  def change
    drop_table :standings
    create_table :standings do |t|
      t.integer :result_id
    end
  end
end
