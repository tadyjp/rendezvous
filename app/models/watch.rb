class Watch < ActiveRecord::Base
  ######################################################################
  # Associations
  ######################################################################
  belongs_to :watcher, class_name: 'User'
  belongs_to :watchable, polymorphic: true

  ######################################################################
  # Validations
  ######################################################################
  validates :watcher_id, uniqueness: { scope: [:watchable_type, :watchable_id] }
end
