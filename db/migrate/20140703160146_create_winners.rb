class CreateWinners < ActiveRecord::Migration
  def change
    create_table :winners do |t|
      t.integer :user_id
      t.integer :auction_id
      t.timestamps
    end
  end
end
