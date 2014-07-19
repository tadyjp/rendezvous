class CreateFootprints < ActiveRecord::Migration
  def change
    create_table :footprints do |t|
      t.integer :user_id, null: false
      t.integer :post_id, null: false

      t.timestamps
    end

    add_index :footprints, [:user_id, :post_id]
    add_index :footprints, :post_id
  end
end
