class CardResource < JSONAPI::Resource
	include GroupCountExtensions

	attributes :hs_card_id, :name_fr, :cost, :atk, :health

	belongs_to :cardset
	belongs_to :cardclass
	belongs_to :rarity
	belongs_to :type
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
			when "owned"
				records.joins(:collections).where(collections: { user_id: value.first[1] })
			when "golden"
				records.joins(:collections).where(collections: { user_id: value.first[1] }).where("collections.golden > 0").where.not(cards: { cardset_id: 2 })
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

	def self.find_count(filters, options = {})
		own = filters[:own]
		filtered_records = filter_records(filters, options)
		if own
			case own.first[0]
			when "owned"
				filtered_records.sum("collections.number")
			when "golden"
				filtered_records.sum("collections.golden")
			when "missing"
				0
			when "wanted"
				0
			when "extra"
				0
			else
				count_records(filtered_records)
			end
		else
			count_records(filtered_records)
		end
	end
end
