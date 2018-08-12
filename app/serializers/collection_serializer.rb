class CollectionSerializer < ActiveModel::Serializer
	attributes :id, :card_id, :user_id, :number
end
