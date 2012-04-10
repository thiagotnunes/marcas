class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :order_status
  belongs_to :service
  belongs_to :invoice

  validates_presence_of :user, :order_status, :service
end
