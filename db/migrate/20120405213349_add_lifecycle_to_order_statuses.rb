class AddLifecycleToOrderStatuses < ActiveRecord::Migration
  def change
    add_column :order_statuses, :lifecycle, :string
  end
end
