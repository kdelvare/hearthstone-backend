class StatsController < JSONAPI::ResourceController
	def index
		render json: {
			data: {
				id: 1,
				type: 'stat',
				attributes: {
					total: Card.count
				}
			}
		}
	end
end
