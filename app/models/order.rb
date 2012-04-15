class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :order_status
  belongs_to :service
  belongs_to :invoice
  has_many :order_attachments

  attr_accessible :order_attachments_attributes

  accepts_nested_attributes_for :order_attachments, :allow_destroy => true

  validates_presence_of :user, :order_status, :service

  def build_pagseguro_order
    pagseguro_order = PagSeguro::Order.new(invoice.id)
    pagseguro_order.add :id => id, :price => service.price, :description => service.description

    pagseguro_order
  end
end
