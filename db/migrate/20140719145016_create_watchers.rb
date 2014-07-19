class CreateWatchers < ActiveRecord::Migration
  def change
    create_table :watchers do |t|
      t.integer :user_id, null: false
      t.string :resource_type, null: false
      t.integer :resource_id, null: false

      t.timestamps
    end

    add_index :watchers, [:user_id, :resource_type, :resource_id], unique: true
    add_index :watchers, [:resource_type, :resource_id]
  end
end
