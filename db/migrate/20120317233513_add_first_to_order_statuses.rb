class AddFirstToOrderStatuses < ActiveRecord::Migration
  def change
    add_column :order_statuses, :first_status, :integer, :limit => 1, :default => 0
  end
end
