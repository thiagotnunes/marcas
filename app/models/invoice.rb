class Invoice < ActiveRecord::Base

  has_many :trademark_orders

end
