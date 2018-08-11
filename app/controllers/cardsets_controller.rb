class CardsetsController < ApplicationController
	def index
		if params[:collectible] == "true"
			render json: Cardset.where(collectible: true)
		else
			render json: Cardset.all
		end
	end
end
