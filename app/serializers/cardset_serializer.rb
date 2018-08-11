class CardsetSerializer < ActiveModel::Serializer
	attributes :hs_id, :name, :name_fr, :collectible, :standard
end
