class DeckResource < JSONAPI::Resource
	attributes :name, :url

	belongs_to :cardclass
	belongs_to :deckgroup
	has_many :deckcards

	def self.default_sort
		[{ field: 'cardclass_id', direction: 'asc' }]
	end
end
