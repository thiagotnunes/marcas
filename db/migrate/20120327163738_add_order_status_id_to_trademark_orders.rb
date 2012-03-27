class AddOrderStatusIdToTrademarkOrders < ActiveRecord::Migration
  def change
    add_column :trademark_orders, :order_status_id, :integer
    add_index :trademark_orders, :order_status_id
  end
end
