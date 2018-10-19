class WantedcardResource < JSONAPI::Resource
	belongs_to :user
	belongs_to :deck
end
