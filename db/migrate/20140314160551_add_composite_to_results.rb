class AddCompositeToResults < ActiveRecord::Migration
  add_column :results, :composite_name, :string
  add_column :results, :composite_uid, :string
end
