class AddCompositeToStanding < ActiveRecord::Migration
  def change
    add_column :standings, :composite_name, :string
    add_column :standings, :composite_uid, :string
  end
end
