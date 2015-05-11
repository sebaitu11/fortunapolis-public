class AddTicketsCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :count_of_tickets, :integer
  end
end


