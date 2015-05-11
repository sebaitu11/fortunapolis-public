class Auction < ActiveRecord::Base

  scope :last_updated, -> {
    order('updated_at DESC, created_at DESC').limit(1)
  }

  belongs_to :category
  belongs_to :product
  has_many :bets ,:dependent => :destroy
  has_many :tickets
  has_many :users ,:through => :bets
  validate :check_total_bets_and_tickets, :if => "bets.size < total_bets"
  has_one :winner,:dependent => :destroy

  state_machine initial: :open do
    event :close do
      transition :open => :closed
    end
    event :finish do
      transition :closed => :finished
    end
  end
  

  def check_total_bets_and_tickets
    if bets.size >= total_bets
      errors.add(:auction,"The auction is Full")
    end
  end

  def set_finish_time
    self.closed_time = Time.now + 3*60
    self.save
  end

  def pick_winner
    winner_bet = self.bets.shuffle.first
    user_winner = winner_bet.user
    return user_winner
  end

end

