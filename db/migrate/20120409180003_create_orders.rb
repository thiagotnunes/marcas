class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user
      t.references :order_status
      t.references :service
      t.references :invoice

      t.timestamps
    end
  end
end
