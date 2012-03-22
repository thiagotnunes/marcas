class TrademarkOrder < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :segment
  validates_length_of :segment, :within => 3..100

  validates_presence_of :subsegment
  validates_length_of :subsegment, :within => 3..100
end
