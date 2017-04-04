class AddCoinsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :coins, :integer, default: 100

    # add a column to wishes to add coin_bucket
    add_column :wishes, :coin_bucket, :integer, default: 0
  end
end
