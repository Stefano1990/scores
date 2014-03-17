class AddStatusToStandings < ActiveRecord::Migration
  def change
    add_column :standings, :status, :string
  end
end
