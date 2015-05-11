 class UsersController < ApplicationController
  # before_action :authenticate
  def user_auctions
    user = User.find(params[:user_id])
    @auctions = user.auctions
    render json: @auctions, id: user.id, root: false
  end
  
  def update
    @user = User.find params[:id]
    if @user.update_attributes user_params
      render status: 200,
      json: {
        success: true, info: "Logged in", data: {
          user: @user,
          tickets: @user.tickets.size,
          auctions: @user.auctions.where.not(state: "finished").size
        }
      }
    else
      respond_with @user
    end
  end

  def show
    @user = User.find(params[:id])
    render json: @user, root: false
  end
  
  def user_params
    params.require(:user).permit(:fullname,:address,:city,:state,:zip,:phone)
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
      self.headers['WWW-Authenticate'] = 'Token realm= "Users"'

      render json: "Bad Credentials", status: 401  
    end

end