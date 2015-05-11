class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :count_of_auctions
      t.timestamps
    end
  end
end
