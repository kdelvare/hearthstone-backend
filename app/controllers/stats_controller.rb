class StatsController < JSONAPI::ResourceController
	def index
		@owned = Card.includes(:collections).where(collections: { user_id: params[:user] }) if params[:user].present?

		total = {
			cardsets: [],
			rarities: [],
			owned: @owned.count,
			total: Card.count,
			rate: 0
		}

		render json: {
			data: {
				id: 1,
				type: 'stat',
				attributes: {
					total: total
				}
			}
		}
	end
end
