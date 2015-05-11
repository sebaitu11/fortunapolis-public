class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.integer :auction_id
      t.integer :user_id
      t.integer :number_of_tickets
      t.timestamps
    end
  end
end
