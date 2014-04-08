class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :post_id
      t.integer :user_id

      t.timestamps

      t.index :post_id
      t.index :user_id
    end
  end
end
