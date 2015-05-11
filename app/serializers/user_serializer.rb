class UserSerializer < ActiveModel::Serializer
  attributes :id,:email,:authentication_token,:fullname,:address,:city,:state,:zip,:phone,:auctions_size

  has_many :tickets

  def auctions_size
    object.auctions.size
  end

end
