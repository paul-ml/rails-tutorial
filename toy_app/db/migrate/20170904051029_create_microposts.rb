class CreateMicroposts < ActiveRecord::Migration[5.1]
  def change
    create_table :microposts do |t|
      t.text :contents
      t.integer :uid

      t.timestamps
    end
  end
end
