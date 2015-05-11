class PaymentsController < ApplicationController
  
  # skip_before_filter :verify_authenticity_token
  respond_to :json

  def charge
    token = params[:stripeToken]
    amount = params[:amount]
     
    payment = Stripe::Charge.create(
      :amount => amount, # amount in cents, again
      :currency => "usd",
      :card => token,
      :description => "something about your customer"
    )
    render :json => payment
  end

end
