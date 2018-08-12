class CardsController < ApplicationController
	def index
		@cards = Card.where.not(type: 3)  # filter Hero cards
		@cards = @cards.cardclass(params[:class]) if params[:class].present?
		@cards = @cards.cost(params[:cost]) if params[:cost].present?
		@cards = @cards.cardset(params[:cardset]) if params[:cardset].present?
		#@cards = @cards.includes(:collections).where(collections: { user_id: [nil, params[:user]] }) if params[:user].present?
		@cards = @cards.limit(14)
		render json: @cards, :include => :collections
	end

	def update
		@card = Card.find(params[:id])
		@card.update(card_params)
		head :no_content
	end

	private

	def card_params
		logger.info "card params: #{params}"
		params.permit(:collections)
	end
end
