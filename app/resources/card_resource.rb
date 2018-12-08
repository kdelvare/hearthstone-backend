class CardResource < JSONAPI::Resource
	include GroupCountExtensions

	attributes :hs_card_id, :name_fr, :cost, :atk, :health

	belongs_to :cardset
	belongs_to :cardclass
	belongs_to :rarity
	belongs_to :type
	has_many :collections
	has_many :wantedcards
	has_many :deckcards

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
			when "goldenb"
				records.joins(:collections).where(collections: { user_id: value.first[1] }).where("collections.golden > 0")
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
			when "goldenb"
				filtered_records.sum("collections.golden")
			when "golden"
				filtered_records.sum("collections.golden")
			when "missing"
				filtered_records.length + filtered_records.where("collections.id IS NULL AND cards.rarity_id <> 5").length
			when "wanted"
				filtered_records.inject(0) do |sum, record|
					sum + record.wantedcards.where(user_id: own.first[1]).maximum(:number)
				end
			when "extra"
				filtered_records.sum("collections.number") - filtered_records.length - filtered_records.where("cards.rarity_id <> 5").length
			else
				count_records(filtered_records)
			end
		else
			count_records(filtered_records)
		end
	end
end
