class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :auctions

  def auctions
    object.auctions.where("state=? OR state=?", 'open','closed')
  end

end
