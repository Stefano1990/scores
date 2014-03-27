class AddFirstEntryLastEntryToResults < ActiveRecord::Migration
  def change
    add_column :results, :first_entry, :integer
    add_column :results, :last_entry, :integer
  end
end
