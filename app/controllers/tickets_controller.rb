class TicketsController < ApplicationController
  # before_action :authenticate
  
  def create
    ticket = Ticket.new(ticket_params)
    if ticket.save
      render  json: ticket, root: false
    else
      render json: ticket.errors, :status => 442
    end
  end
  def destroy
    user = current_user
    user.tickets.last.destroy
    render :json=> {:tickets=> user.tickets}
  end

  def ticket_params
    params.permit(:valor,:user_id)
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
