class RaritiesController < ApplicationController
	def index
		if params[:collectible] == "true"
			render json: Rarity.where(collectible: true)
		else
			render json: Rarity.all
		end
	end
end
