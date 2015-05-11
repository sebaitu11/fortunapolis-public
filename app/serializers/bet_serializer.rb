class BetSerializer < ActiveModel::Serializer
  attributes :id, :auction_id , :user_id

  has_one :auction

end
