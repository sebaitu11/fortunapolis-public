class AuctionsController < ApplicationController
  
  def index
    @auctions = Auction.search(params[:query])
    render json: @auctions, root: false
  end

  def show
    auction = Auction.find(params[:id])
    render json: auction, root: false
  end


  def finished_auctions
    user = User.find(params[:user_id])
    auctions = user.auctions.where(state: "finished")
    render json: auctions, root: false
  end

  def create
    auction = Auction.new(auction_params)
    if auction.save
      render :json=> {:auction=> auction}
    end
  end

  def auction_params
    params.permit(:total_bets,:tickets_by_bet ,:user_id)
  end

  def search
    @auctions = Auction.search(params[:search])
    render json: @auctions, root: false
  end
end
