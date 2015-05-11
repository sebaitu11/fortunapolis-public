class AddProductIdtoAuction < ActiveRecord::Migration
  def change
    add_column :auctions, :product_id, :integer
    remove_column :products, :auction_id

  end
end
