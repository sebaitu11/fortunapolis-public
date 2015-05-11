class WelcomeController < ApplicationController  
  # GET /
  def index
    gon.environment = Rails.env
  end
end
