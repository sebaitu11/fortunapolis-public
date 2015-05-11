class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.timestamps :remaining_time
      t.integer :total_bets
      t.integer :remaining_bets
      t.integer :tickets_by_bet
      t.timestamps
    end
  end
end
