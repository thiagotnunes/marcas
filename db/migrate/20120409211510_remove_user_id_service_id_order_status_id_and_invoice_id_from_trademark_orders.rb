class RemoveUserIdServiceIdOrderStatusIdAndInvoiceIdFromTrademarkOrders < ActiveRecord::Migration
  def change
    remove_column :trademark_orders, :user_id
    remove_column :trademark_orders, :service_id
    remove_column :trademark_orders, :order_status_id
    remove_column :trademark_orders, :invoice_id
  end
end
