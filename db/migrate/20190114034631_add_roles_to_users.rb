class AddRolesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :admin, :boolean
    add_column :users, :customer, :boolean
     add_column :users, :moderator, :boolean
  end
end
