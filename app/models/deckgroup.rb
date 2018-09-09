class Deckgroup < ActiveRecord::Base
	has_many :decks

	def create
		respond_with Deckgroup.create(deckgroup_params)
	end

	private

	def deck_params
		params.require(:deckgroup).permit(:name, :url)
	end
end
