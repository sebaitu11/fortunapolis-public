class AddStateToAuction < ActiveRecord::Migration
  def change
    add_column :auctions, :state, :string
  end
end
