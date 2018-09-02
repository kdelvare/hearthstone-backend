class CollectionResource < JSONAPI::Resource
	attributes :number

	belongs_to :user
	belongs_to :card

	filters :user, :card
end
