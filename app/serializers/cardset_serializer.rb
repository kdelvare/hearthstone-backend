class CardsetSerializer < ActiveModel::Serializer
	attributes :id, :type, :name, :name_fr, :collectible, :standard
end
