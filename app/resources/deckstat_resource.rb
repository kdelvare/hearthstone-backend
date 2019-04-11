class DeckstatResource < JSONAPI::Resource
	attributes :win, :loose, :win_casual, :loose_casual

	belongs_to :deck
	belongs_to :user
end
