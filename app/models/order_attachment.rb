class OrderAttachment < ActiveRecord::Base
  belongs_to :trademark_order, :polymorphic => true

  mount_uploader :file, OrderAttachmentUploader
end
