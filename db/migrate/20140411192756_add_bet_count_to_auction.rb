class AddBetCountToAuction < ActiveRecord::Migration
  def change
    add_column :auctions, :count_of_bets, :integer
  end
end
