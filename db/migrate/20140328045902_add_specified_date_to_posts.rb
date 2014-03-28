class AddSpecifiedDateToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :specified_date, :date
  end
end
