class CardsController < ApplicationController
	def index
		@cards = Card.where.not(type: 3).or(Card.where("cost > ?", 0))  # filter basic Hero cards
		@cards = @cards.cardclass(params[:class]) if params[:class].present?
		@cards = @cards.cost(params[:cost]) if params[:cost].present?
		@cards = @cards.cardset(params[:cardset]) if params[:cardset].present?
		#@cards = @cards.includes(:collections).where(collections: { user_id: [nil, params[:user]] }) if params[:user].present?
		@cards = @cards.limit(params[:limit]) if params[:limit].present?
		@cards = @cards.order(:cost, :name_fr)
		render json: @cards, :include => [:cardset, :rarity, :collections]
	end

	def show
		@card = Card.find(params[:id])
		render json: @card, :include => [:cardclass]
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
