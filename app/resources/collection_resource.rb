class CollectionResource < JSONAPI::Resource
	attributes :number, :completion, :golden

	belongs_to :user
	belongs_to :card

	filters :user, :card
end
