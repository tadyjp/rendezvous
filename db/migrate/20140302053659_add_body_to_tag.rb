class AddBodyToTag < ActiveRecord::Migration
  def change
    add_column :tags, :body, :text
  end
end
