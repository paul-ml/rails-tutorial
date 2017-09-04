class ChangeColumnNameUidToUserId < ActiveRecord::Migration[5.1]
  def change
  	rename_column :microposts, :uid, :user_id
  end
end
