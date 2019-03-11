class AddNicknameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nickname, :string, default: '', null: false

    add_index 'users', ['nickname']
  end
end
