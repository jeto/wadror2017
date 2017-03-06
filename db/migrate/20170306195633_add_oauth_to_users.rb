class AddOauthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :oauth, :boolean, :default => false
  end
end
