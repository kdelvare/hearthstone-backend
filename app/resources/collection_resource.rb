class CollectionResource < JSONAPI::Resource
	attributes :number, :completion

	belongs_to :user
	belongs_to :card

	filters :user, :card
end
