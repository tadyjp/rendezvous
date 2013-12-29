class AddRefreshTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :google_refresh_token, :string
    add_column :users, :google_token_expires_at, :datetime
  end
end
