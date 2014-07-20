class CreateWatches < ActiveRecord::Migration
  def change
    create_table :watches do |t|
      t.integer :user_id, null: false
      t.string  :watchable_type, null: false
      t.integer :watchable_id, null: false

      t.timestamps
    end

    add_index :watches, [:user_id, :watchable_type, :watchable_id], unique: true
    add_index :watches, [:watchable_type, :watchable_id]
  end
end
