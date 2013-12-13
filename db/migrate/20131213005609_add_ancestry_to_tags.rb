class AddAncestryToTags < ActiveRecord::Migration
  def change
    add_column :tags, :ancestry, :string

    add_index :tags, :ancestry
  end
end
