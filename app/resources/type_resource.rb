class TypeResource < JSONAPI::Resource
	attributes :name_fr

	filter :collectible,
		verify: ->(values, context) {
			values.map { |value| value.casecmp('true') == 0 }
		}
end
