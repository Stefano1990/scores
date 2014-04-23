class AddCustomerIdToDrivers < ActiveRecord::Migration
  def change
    add_column :drivers, :customer_id, :integer
  end
end
