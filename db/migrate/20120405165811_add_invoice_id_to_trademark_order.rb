class AddInvoiceIdToTrademarkOrder < ActiveRecord::Migration
  def change
    add_column :trademark_orders, :invoice_id, :integer
    add_index :trademark_orders, :invoice_id
  end
end
