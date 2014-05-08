class AddResultIdToRounds < ActiveRecord::Migration
  def change
    add_column :rounds, :result_id, :integer
  end
end
