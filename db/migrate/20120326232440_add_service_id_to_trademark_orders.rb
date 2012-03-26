class AddServiceIdToTrademarkOrders < ActiveRecord::Migration
  def change
    add_column :trademark_orders, :service_id, :integer
    add_index :trademark_orders, :service_id
  end
end
