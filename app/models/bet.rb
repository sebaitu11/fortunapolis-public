class Bet < ActiveRecord::Base
  belongs_to :user
  belongs_to :auction ,counter_cache: :count_of_bets
  has_many :tickets, :through => :auction
  after_create :check_user_tickets, :pay_tickets, :check_full, :stream
  scope :user_bets, -> (user_id){ where(:user_id => user_id) }

  validates_associated :auction

  def check_user_tickets
    if user.tickets.size >= auction.tickets_by_bet
      true
    else
      self.errors.add(:bet, "You need more tickes you have #{user.tickets.count}")
      false
    end
  end

  def stream
    msg = { resource: 'bets',
      id: self.id,
      obj: self,
      category_id: self.auction.category_id,
      bets_on_auction: self.auction.bets.size,
      state: self.auction.state }

    $redis.publish 'rt-change', msg.to_json
  end

  def check_full
    if auction.bets.size == auction.total_bets
      auction.close
      auction.set_finish_time

      HardWorker.perform_in(10.seconds,auction.id)
    end
  end

  def pay_tickets
    x = auction.tickets_by_bet 
    x.times do |i|
      ticket = user.tickets.first 
      self.auction.tickets << ticket
      ticket.pay
    end
  end
end
