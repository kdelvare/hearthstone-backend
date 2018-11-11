class Deck < ActiveRecord::Base
	belongs_to :cardclass
	belongs_to :deckgroup
	has_many :deckcards
	has_many :cards, through: :deckcards
	has_many :wanteddecks

	def create
		respond_with Deck.create(deck_params)
	end

	private

	def deck_params
		params.require(:deck).permit(:name, :url, :cardclass_id)
	end
end
