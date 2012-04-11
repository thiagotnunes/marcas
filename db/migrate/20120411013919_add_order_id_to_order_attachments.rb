class AddOrderIdToOrderAttachments < ActiveRecord::Migration
  def change
    add_column :order_attachments, :order_id, :integer
    add_index :order_attachments, :order_id
  end
end
