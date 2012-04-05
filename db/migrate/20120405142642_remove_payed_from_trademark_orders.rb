class RemovePayedFromTrademarkOrders < ActiveRecord::Migration
  def change
    remove_column :trademark_orders, :payed 
  end
end
