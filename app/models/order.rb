class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :order_status
  belongs_to :service
  belongs_to :invoice
  has_many :order_attachments

  attr_accessible :order_attachments_attributes

  accepts_nested_attributes_for :order_attachments, :allow_destroy => true

  validates_presence_of :user, :order_status, :service

  def pagseguro_billing_data
    {
      "email" => PagSeguro.config["email"],
      "token" => PagSeguro.config["authenticity_token"],
      "currency" => "BRL",
      "reference" => invoice.id,
      "itemQuantity1" => "1",
      "itemId1" => id,
      "itemDescription1" => service.name,
      "itemAmount1" => ("%.2f" % service.price)
    }
  end
end
