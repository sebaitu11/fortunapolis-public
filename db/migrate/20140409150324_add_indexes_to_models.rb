class AddIndexesToModels < ActiveRecord::Migration
  def change
    add_index :bets, :auction_id
    add_index :bets, :user_id
    add_index :auctions, :id
    add_index :auctions, :total_tickets_value
    add_index :auctions, :total_bets
    add_index :auctions, :tickets_by_bet
  end
end
