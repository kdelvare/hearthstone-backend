class DeckcardsController < ApplicationController
	def create
		@deckcard = Deckcard.create!(deckard_params)
		render json: @deckcard, status: :created
	end

	private

	def deckard_params
		params[:deck_id] = params[:deck]
		params[:card_id] = params[:card]
		params.permit(:deck_id, :card_id, :number)
	end
end
