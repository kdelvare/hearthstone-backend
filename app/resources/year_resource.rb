class YearResource < JSONAPI::Resource
	attributes :name_fr, :standard

	has_many :cardsets

	filter :standard,
		verify: ->(values, context) {
			values.map { |value| value.casecmp('true') == 0 }
		}
end
