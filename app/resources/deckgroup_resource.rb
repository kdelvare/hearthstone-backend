class DeckgroupResource < JSONAPI::Resource
	attributes :name, :url

	belongs_to :cardset
	has_many :decks

	filters :cardset

	filter :cardclass,
		apply: ->(records, value, _options) {
			records.includes(:decks).where(decks: { cardclass: value })
		}

	def self.sortable_fields(context)
		super + [:"decks.cardclass_id"]
	end

	def self.apply_sort(records, order_options, context = {})
		if order_options.has_key?('decks.cardclass_id')
			records = records.includes(:decks).order('decks.cardclass_id')
			order_options.delete('decks.cardclass_id')
		end

		super(records, order_options, context)
	end
end
