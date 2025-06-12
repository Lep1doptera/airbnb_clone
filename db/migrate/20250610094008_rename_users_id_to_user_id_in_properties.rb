class RenameUsersIdToUserIdInProperties < ActiveRecord::Migration[7.1]
  def change
    rename_column :properties, :users_id, :user_id
  end
end
