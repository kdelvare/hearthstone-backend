class CardclassResource < JSONAPI::Resource
	attributes :name_fr, :collectible

	#has_many :cards

	filter :collectible,
		verify: ->(values, context) {
			values.map { |value| value.casecmp('true') == 0 }
		}

	filter :card_id
end
