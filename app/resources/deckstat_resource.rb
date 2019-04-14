class DeckstatResource < JSONAPI::Resource
	attributes :win, :loose, :wincasual, :loosecasual

	belongs_to :deck
	belongs_to :user
end
