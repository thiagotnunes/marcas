class AddUserIdToTrademarkOrders < ActiveRecord::Migration
  def change
    add_column :trademark_orders, :user_id, :integer
    add_index :trademark_orders, :user_id
  end
end
