class AddTrademarkOrderIdToOrderAttachments < ActiveRecord::Migration
  def change
    add_column :order_attachments, :trademark_order_id, :integer
    add_index :order_attachments, :trademark_order_id
  end
end
