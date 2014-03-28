class AddRoundToResults < ActiveRecord::Migration
  def change
    add_column :results, :round, :string
  end
end
