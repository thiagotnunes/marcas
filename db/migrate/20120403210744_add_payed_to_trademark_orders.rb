class AddPayedToTrademarkOrders < ActiveRecord::Migration
  def change
    add_column :trademark_orders, :payed, :integer, :default => 0, :limit => 1
  end
end
