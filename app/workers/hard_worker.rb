class HardWorker
  include Sidekiq::Worker

  def perform(auction_id)
    auction = Auction.find(auction_id)
    winner = auction.pick_winner
    Winner.create(user_id: winner.id,auction_id: auction_id)

    new_auction = Auction.new(total_bets: auction.total_bets,tickets_by_bet: auction.tickets_by_bet,
      state: "open",category_id: auction.category_id,product_id: auction.product_id)

    if new_auction.save
      auction.finish
    end

  end
end