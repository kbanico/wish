class CreateWishes < ActiveRecord::Migration[5.0]
  def change
    create_table :wishes do |t|
      t.text :description
      t.integer :user_id
      t.timestamps
    end
    add_index :wishes, :user_id
  end
end
