class BetsController < ApplicationController
  # before_action :authenticate

  def create
    bet = Bet.new(bets_params)
    bet.user = User.find(params[:user_id])
    if bet.save
      render status: 200,
      json: {
        success: true, info: "created", data: {
          tickets: bet.user.tickets.size,
          auctions: bet.user.auctions.where.not(state: "finished").size,
          bets_on_auction: bet.auction.bets.size,
          auction: bet.auction.closed_time
        }
      }
    else
      render json: bet.errors,  :status=>422
    end
  end

  def email
    user = User.find(params[:user_id])
    amount = params[:amount]
    BetMailer.delay.bet_complete(user.email,user.fullname,amount)
    render status: 200,
    json: { success: true}
  end

  def bets_params
    params.permit(:auction_id,:user_id,:amount)
  end

 protected 

    def authenticate
      authenticate_token || render_unauthorized
    end

    def authenticate_token
      authenticate_with_http_token do |token,options|
        User.find_by(authentication_token: token)
     end
    end

    def render_unauthorized
      self.headers['WWW-Authenticate'] = 'Token realm= "Bets"'

      render json: "Bad Credentials", status: 401  
    end


end
