class DeckstatResource < JSONAPI::Resource
	attributes :win, :loose

	belongs_to :deck
	belongs_to :user
end
