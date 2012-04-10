class AddOrderIdToTrademarkOrders < ActiveRecord::Migration
  def change
    add_column :trademark_orders, :order_id, :integer
    add_index :trademark_orders, :order_id
  end
end
