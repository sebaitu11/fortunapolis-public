class AddAuctionidToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :auction_id, :integer
  end
end
