class TrademarkOrder < ActiveRecord::Base
  belongs_to :user
  belongs_to :service
  belongs_to :order_status
  has_many :order_attachments

  attr_accessible :name, :segment, :subsegment, :observations, :service_id, :order_attachments_attributes

  default_scope :order => 'service_id DESC'

  validates_presence_of :segment
  validates_length_of :segment, :within => 3..100

  validates_presence_of :subsegment
  validates_length_of :subsegment, :within => 3..100

  accepts_nested_attributes_for :order_attachments, :allow_destroy => true

  def pay
    update_attribute(:payed, 1)
  end
end
