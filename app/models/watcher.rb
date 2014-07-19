class Watcher < ActiveRecord::Base
  belongs_to :user
  belongs_to :resource, polymorphic: true
end
