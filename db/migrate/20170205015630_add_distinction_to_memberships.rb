class AddDistinctionToMemberships < ActiveRecord::Migration
  def change
    add_index :memberships, [:beer_club_id, :user_id], unique: true
  end
end
