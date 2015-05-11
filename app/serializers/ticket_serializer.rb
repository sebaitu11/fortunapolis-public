class TicketSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :state, :valor
end
