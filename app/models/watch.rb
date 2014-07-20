class Watch < ActiveRecord::Base
  belongs_to :watcher, class_name: 'User'
  belongs_to :watchable, polymorphic: true
end
