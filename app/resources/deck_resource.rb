class DeckResource < JSONAPI::Resource
	attributes :name, :url

	belongs_to :cardclass
	belongs_to :deckgroup
	has_many :deckcards
	has_many :wanteddecks

	filters :cardclass

	filter :cardset,
		apply: ->(records, value, _options) {
			records.joins(:deckgroup).where(deckgroups: { cardset: value })
		}

	def self.default_sort
		[{ field: 'cardclass_id', direction: 'asc' }]
	end
end
