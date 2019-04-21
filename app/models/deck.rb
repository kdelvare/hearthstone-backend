class Deck < ActiveRecord::Base
	belongs_to :cardclass
	belongs_to :deckgroup, optional: true
	belongs_to :user, optional: true
	has_many :deckcards, dependent: :delete_all
	has_many :cards, through: :deckcards
	has_many :wanteddecks
	has_many :deckstats

	def create
		respond_with Deck.create(deck_params)
	end

	private

	def deck_params
		params.require(:deck).permit(:name, :url, :deckstring, :cardclass_id)
	end
end
