class AddIsDraftToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :is_draft, :boolean, default: false

    add_index :posts, :is_draft
  end
end
