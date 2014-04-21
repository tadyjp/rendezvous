class AddPostsCountToTags < ActiveRecord::Migration
  def change
    add_column :tags, :posts_count, :integer, default: 0, null: false
  end
end
