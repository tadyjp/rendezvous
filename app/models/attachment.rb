class Attachment < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true
  # attr_accessible :file, :attachable_id, :attachable_type
  mount_uploader :file, FileUploader
end
