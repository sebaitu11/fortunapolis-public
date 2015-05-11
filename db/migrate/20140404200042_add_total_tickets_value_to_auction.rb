class AddTotalTicketsValueToAuction < ActiveRecord::Migration
  def change
    add_column :auctions, :total_tickets_value, :integer
  end
end
