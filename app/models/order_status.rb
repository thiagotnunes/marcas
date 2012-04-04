class OrderStatus < ActiveRecord::Base
  has_many :trademark_orders

  default_scope :order => 'first_status DESC'

  validates_presence_of :status, :first_status

  validates_length_of :status, :within => 3..50

  validates_uniqueness_of :status

  def first?
    first_status != 0
  end

  def self.remove_first_flag
    update_all("first_status = 0", "first_status = 1")
  end

  def self.all_first_status
    find(:all, :order => "first_status")
  end

  def self.find_first
    first(:conditions => ["first_status = 1"])
  end
  def self.find_after_payment
    first(:conditions => ["after_payment = 1"])
  end
end
