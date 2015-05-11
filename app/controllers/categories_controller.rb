class CategoriesController < ApplicationController
  # before_filter :authenticate_user_from_token!, :only => [:index, :show]

  def index
     user = User.find(params[:user_id])
     auctions = Category.all
     render json: auctions, id: user.id  , root: false
  end

  def show
    category = Category.find(params[:id])
    render json: category, root: false
  end

end
