class User < ActiveRecord::Base
  before_save :ensure_authentication_token
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tickets ,-> { with_state(:available) }
  has_many :bets ,:dependent => :destroy
  has_many :auctions,  -> { uniq }, :through => :bets ,:dependent => :destroy

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end

  def clear_authentication_token
    self.authentication_token = nil
    self.save
  end


end
