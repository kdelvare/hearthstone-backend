class WantedcardsController < JSONAPI::ResourceController
	prepend_before_action :include_user

	def include_user
		if params[:include] == nil
			params[:include] = 'user,wanteddeck,wanteddeck.deck,wanteddeck.deck.cardclass,wanteddeck.deck.deckgroup'
			params[:fields] = {}
			params[:fields][:wanteddecks] = 'deck'
			params[:fields][:decks] = 'name,cardclass,deckgroup'
		end
	end
end
