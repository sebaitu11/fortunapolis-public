class AddCategoryToAuction < ActiveRecord::Migration
  def change
    add_column :auctions, :category_id, :integer
  end
end
