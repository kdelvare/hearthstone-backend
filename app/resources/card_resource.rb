class CardResource < JSONAPI::Resource
	attributes :hs_card_id, :name_fr, :cost

	belongs_to :cardset
	belongs_to :cardclass
	#belongs_to :type
	belongs_to :rarity
	has_many :collections

	filter :collectible,
		apply: ->(records, value, _options) {
			records.where.not(type_id: 3).or(records.where("cost > ?", 0)) # filter basic Hero cards
		}

	filter :limit,
		apply: ->(records, value, _options) {
			#logger = Logger.new(STDOUT)
			#logger.info "Limit filter value: #{value}"
			records.limit(value.first)
		}

	filters :cardclass, :cost, :cardset, :user

	class << self
		def apply_filter(records, filter, value, options)
			case filter
				when :user
					records.joins("LEFT JOIN collections ON collections.card_id = cards.hs_id AND collections.user_id = #{value[0]}")
				else
					return super(records, filter, value)
			end
		end
	end
end
