class DeckSerializer < ActiveModel::Serializer
	attributes :id, :name, :url
	belongs_to :cardclass
	has_many :deckcards
end
