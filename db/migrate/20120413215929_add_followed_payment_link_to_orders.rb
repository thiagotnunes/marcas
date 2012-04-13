class AddFollowedPaymentLinkToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :followed_payment_link, :integer, :default => 0, :limit => 1
  end
end
