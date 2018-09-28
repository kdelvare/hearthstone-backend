class StatsController < JSONAPI::ResourceController
	def index
		@collectible = Card.where.not(type_id: 3).or(Card.where("cost > ?", 0)) # filter basic Hero cards
		@owned = Card.includes(:collections).where(collections: { user_id: params[:user] }) if params[:user].present?
		@cardsets = Cardset.where(collectible: true)
		@rarities = Rarity.where(collectible: true)

		total = {
			:cardsets => [],
			:rarities => [],
			:owned => @owned.count,
			:total => @collectible.count
		}

		@cardsets.each do |cardset|
			total[:cardsets][cardset.id] = {
				rarities: [],
				owned: @owned.where(cardset: cardset.id).count,
				total: @collectible.where(cardset: cardset.id).count
			}
		end

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
