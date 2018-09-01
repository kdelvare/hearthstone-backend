class DecksController < ApplicationController
	def index
		render json: Deck.all
	end

	def show
		render json: Deck.find(params[:id])
	end

	def create
		@deck = Deck.create(deck_params)
		render json: @deck, status: :created
	end

	private

	def deck_params
		params[:cardclass_id] = params[:cardclass]
		params.permit(:name, :url, :cardclass_id)
	end
end
