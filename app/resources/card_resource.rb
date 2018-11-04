class CardResource < JSONAPI::Resource
	include GroupCountExtensions

	attributes :hs_card_id, :name_fr, :cost

	belongs_to :cardset
	belongs_to :cardclass
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

	filter :own,
		apply: ->(records, value, _options) {
			case value.first[0]
			when "missing"
				records.joins("LEFT JOIN collections ON collections.card_id = cards.hs_id AND collections.user_id = #{value.first[1]}").where("(collections.number = 1 AND cards.rarity_id <> 5) OR collections.id IS NULL")
			when "wanted"
				records.joins(:wantedcards).where(wantedcards: { user_id: value.first[1] }).group("wantedcards.card_id").extending(GroupCountExtensions)
			when "extra"
				records.joins(:collections).where(collections: { user_id: value.first[1] }).where("collections.number > 2 OR (cards.rarity_id = 5 AND collections.number > 1)")
			else
				records
			end
		}
end
