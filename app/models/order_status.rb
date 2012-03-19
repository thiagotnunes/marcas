class OrderStatus < ActiveRecord::Base

  default_scope :order => 'first_status DESC'

  validates_presence_of :status, :color, :first_status

  validates_length_of :status, :within => 3..20
  validates_length_of :color, :is => 7

  validates_uniqueness_of :status

  validates_format_of :color, :with => /^#([\dABCDEF]){6}$/i

  def first?
    first_status != 0
  end

  def self.remove_first_flag
    update_all("first_status = 0", "first_status = 1")
  end

  def self.all_first_status
    find(:all, :order => "first_status")
  end
end
