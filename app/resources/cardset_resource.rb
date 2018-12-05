class CardsetResource < JSONAPI::Resource
	attributes :name_fr, :standard

	belongs_to :year

	filter :collectible,
		verify: ->(values, context) {
			values.map { |value| value.casecmp('true') == 0 }
		}
end
