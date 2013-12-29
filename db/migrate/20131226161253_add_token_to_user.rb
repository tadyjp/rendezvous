class AddTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :google_auth_token, :string
  end
end
