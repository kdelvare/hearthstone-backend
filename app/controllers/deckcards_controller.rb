class DeckcardsController < JSONAPI::ResourceController
	prepend_before_action :include_deck

	def include_deck
		if params[:include] == nil
			params[:include] = 'deck,deck.cardclass,deck.deckgroup'
			params[:fields] = {}
			params[:fields][:decks] = 'name,cardclass,deckgroup'
		end
	end
end
