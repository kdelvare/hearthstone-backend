class PackResource < JSONAPI::Resource
	attributes :number

	belongs_to :user
	belongs_to :cardset

	filters :user, :cardset
end
