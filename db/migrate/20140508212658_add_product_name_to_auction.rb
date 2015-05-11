class AddProductNameToAuction < ActiveRecord::Migration
  def change
    add_column :auctions, :product_name, :string
  end
end
