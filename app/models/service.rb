class Service < ActiveRecord::Base
  belongs_to :order_type

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_length_of :name, :within => 3..50

  validates_presence_of :price
  validates_numericality_of :price

  validates_presence_of :order_type_id
end
