class TrademarkOrder < ActiveRecord::Base
  belongs_to :purchase, :foreign_key => 'order_id', :class_name => Order
  has_many :order_attachments

  attr_accessible :name, :segment, :subsegment, :observations, :service_id, :order_attachments_attributes

  validates_presence_of :segment
  validates_length_of :segment, :within => 3..100

  validates_presence_of :subsegment
  validates_length_of :subsegment, :within => 3..100

  accepts_nested_attributes_for :order_attachments, :allow_destroy => true

  def self.all_for_user(id)
    all(:conditions => ["user_id = ?", id], :joins => [:purchase])
  end
end
