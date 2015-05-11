class AddClosedTimeToAuction < ActiveRecord::Migration
  def change
    add_column :auctions, :closed_time, :timestamp
  end
end
