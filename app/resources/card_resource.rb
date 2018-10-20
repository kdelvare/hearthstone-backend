class CardResource < JSONAPI::Resource
	attributes :hs_card_id, :name_fr, :cost

	belongs_to :cardset
	belongs_to :cardclass
	#belongs_to :type
	belongs_to :rarity
	has_many :collections
	has_many :wantedcards

	paginator :paged

	filters :cardclass, :cost, :rarity, :cardset

	filter :collectible,
		apply: ->(records, value, _options) {
			records.where.not(type_id: 3).or(records.where("cost > ?", 0)) # filter basic Hero cards
		}

	filter :limit,
		apply: ->(records, value, _options) {
			records.limit(value.first)
		}

	filter :standard,
		apply: ->(records, value, _options) {
			records.joins(:cardset).where(cardsets: { standard: true })
		}

	filter :missing,
		apply: ->(records, value, _options) {
			records.joins("LEFT JOIN collections ON collections.card_id = cards.hs_id AND collections.user_id = #{value.first}").where("(collections.number = 1 AND cards.rarity_id <> 5) OR collections.id IS NULL")
		}
end
