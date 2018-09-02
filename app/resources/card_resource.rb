class CardResource < JSONAPI::Resource
	attributes :hs_card_id, :name_fr, :cost
	#belongs_to :cardset
	#belongs_to :rarity

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
					records.where('collections.user_id = ? OR collections.user_id IS NULL', value)
				else
					return super(records, filter, value)
			end
		end
	end
end
