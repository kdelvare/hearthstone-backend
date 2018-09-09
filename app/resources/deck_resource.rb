class DeckResource < JSONAPI::Resource
	attributes :name, :url

	belongs_to :cardclass
	has_many :deckcards
end
