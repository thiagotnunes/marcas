class OrderAttachment < ActiveRecord::Base
  belongs_to :order, :polymorphic => true

  mount_uploader :file, OrderAttachmentUploader
end
