class RemoveReaminingBetFromAuction < ActiveRecord::Migration
  def change
    remove_column :auctions, :remaining_bets
  end
end
