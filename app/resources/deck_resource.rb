class DeckResource < JSONAPI::Resource
	attributes :name, :url, :deckstring, :comment

	belongs_to :cardclass
	belongs_to :deckgroup
	belongs_to :user
	has_many :deckcards
	has_many :wanteddecks
	has_many :deckstats

	filters :cardclass, :user

	filter :cardset,
		apply: ->(records, value, _options) {
			records.joins(:deckgroup).where(deckgroups: { cardset: value })
		}

	def self.default_sort
		[{ field: 'cardclass_id', direction: 'asc' }]
	end

	def self.sortable_fields(context)
		super + [:"deckgroup.id"]
	end
end
