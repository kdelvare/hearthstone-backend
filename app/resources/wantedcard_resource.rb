class WantedcardResource < JSONAPI::Resource
	attributes :number

	belongs_to :user
	belongs_to :card
	belongs_to :wanteddeck
end
