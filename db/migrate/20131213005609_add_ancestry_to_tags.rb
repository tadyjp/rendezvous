class AddAncestryToTags < ActiveRecord::Migration
  def change
    add_column :tags, :ancestry, :string
  end
end
