class CardclassSerializer < ActiveModel::Serializer
	attributes :id, :type, :name, :name_fr, :collectible
end
