class OrderStatus < ActiveRecord::Base

  validates_presence_of :status, :color

  validates_length_of :status, :within => 3..20
  validates_length_of :color, :is => 7

  validates_uniqueness_of :status

  validates_format_of :color, :with => /^#([\dABCDEF]){6}$/i

end
