class OrderAttachment < ActiveRecord::Base
  validates_presence_of :file
  validates_uniqueness_of :file
  validates_length_of :file, :within => 3..200

  validates_presence_of :filetype
  validates_length_of :filetype, :within => 3..50
end
