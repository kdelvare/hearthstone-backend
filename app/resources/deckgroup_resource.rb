class DeckgroupResource < JSONAPI::Resource
	attributes :name, :url

	belongs_to :cardset
	has_many :decks

	filters :cardset

	filter :cardclass,
	apply: ->(records, value, _options) {
		records.includes(:decks).where(decks: { cardclass: value })
	}
end
