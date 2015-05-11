class RemoveNumberOfTicketsFromBet < ActiveRecord::Migration
  def change
    remove_column :bets, :number_of_tickets
  end
end
