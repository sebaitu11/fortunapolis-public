class BetMailer < ActionMailer::Base
  default from: 'notifications@fortunapolis.com'
  
  def bet_complete(user_email,user_name,amount)
    @fullname = user_name
    @amount = amount
    mail(to: user_email, subject: 'Your Bet Was made')
  end

  def auction_complete(email,auction_name)
    @auction = auction_name
    mail(to: email, subject: 'The auction is full')
  end
end