class DeckcardResource < JSONAPI::Resource
	attributes :number

	belongs_to :deck
	belongs_to :card
end
