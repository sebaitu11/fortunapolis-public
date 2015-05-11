class AddStateToBet < ActiveRecord::Migration
  def change
    add_column :bets, :state, :string
  end
end
