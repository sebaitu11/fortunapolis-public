class Ticket < ActiveRecord::Base
  belongs_to :user 
  belongs_to :auction
  scope :available, -> { with_state(:available) }
  scope :user_tickets_used, ->(user_id) { where("user_id = ? and state = ?",user_id,"used")}

  state_machine initial: :available do
    event :pay do
      transition :available => :used
    end
  end
end
