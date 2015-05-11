class AuctionSerializer < ActiveModel::Serializer
  attributes :id,:total_bets,:tickets_by_bet,:bets_on_auction,:finish_time,:state,:product,:product_name,:category_id,:user_bets,:winner,:closed_time

  has_one :product

  def bets_on_auction
    object.bets.size 
  end
  
  def finish_time
   object.created_at if object.state != "closed"
  end

  def user_bets
    object.bets.where(user_id: options[:id]).size
  end

  def winner
    if object.winner
      user = User.find(object.winner.user_id)
      return user.fullname
    end
  end
end
