class WanteddeckResource < JSONAPI::Resource
	belongs_to :user
	belongs_to :deck
	has_many :wantedcards
end
