class CardsController < ApplicationController
	def index
		#render json: Card.all
		render json: Card.limit(5)
	end
end
