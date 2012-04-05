class DropColumsFirstStatusAndAfterPaymentFromOrderStatuses < ActiveRecord::Migration
  def change
    remove_column :order_statuses, :first_status
    remove_column :order_statuses, :after_payment
  end
end
