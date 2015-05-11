class RemoveCountOfTickets < ActiveRecord::Migration
  def change
    remove_column :users, :count_of_tickets

  end
end
