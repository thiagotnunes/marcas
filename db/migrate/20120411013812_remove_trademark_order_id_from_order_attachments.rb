class RemoveTrademarkOrderIdFromOrderAttachments < ActiveRecord::Migration
  def change
    remove_column :order_attachments, :trademark_order_id
  end
end
