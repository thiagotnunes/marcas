class AddAfterPaymentToOrderStatuses < ActiveRecord::Migration
  def change
    add_column :order_statuses, :after_payment, :integer, :limit => 1, :default => 0
  end
end
