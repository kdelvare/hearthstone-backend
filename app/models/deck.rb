class Deck < ActiveRecord::Base
	belongs_to :cardclass
	has_many :deckcards
	has_many :cards, through: :deckcards

	def create
		respond_with Deck.create(deck_params)
	end

	private

	def deck_params
		params.require(:deck).permit(:name, :url, :cardclass_id)
	end
end
