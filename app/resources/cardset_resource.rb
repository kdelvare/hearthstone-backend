class CardsetResource < JSONAPI::Resource
	attributes :name_fr

	#has_many :cards

	filter :collectible,
		verify: ->(values, context) {
			values.map { |value| value.casecmp('true') == 0 }
		}
end
