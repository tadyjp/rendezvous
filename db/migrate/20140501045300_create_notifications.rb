class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.datetime :read_at
      t.boolean :is_read, null: false, default: false
      t.string :detail_path
      t.text :body

      t.timestamps
    end

    add_index :notifications, [:user_id, :is_read, :read_at]
  end
end
