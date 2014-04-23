class RemoveResultIdFromPenalty < ActiveRecord::Migration
  def change
    remove_column :penalties, :result_id
  end
end
