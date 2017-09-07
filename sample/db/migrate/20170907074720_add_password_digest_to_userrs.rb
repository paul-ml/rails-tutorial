class AddPasswordDigestToUserrs < ActiveRecord::Migration[5.1]
  def change
    add_column :userrs, :password_digest, :string
  end
end
