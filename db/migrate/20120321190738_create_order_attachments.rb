class CreateOrderAttachments < ActiveRecord::Migration
  def change
    create_table :order_attachments do |t|
      t.string :file
      t.string :filetype

      t.timestamps
    end
  end
end
