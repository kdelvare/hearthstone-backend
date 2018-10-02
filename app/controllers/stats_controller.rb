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
			:owned_std => @owned.joins(:cardset).where(cardsets: { standard: true }).count,
			:total => @collectible.count,
			:total_std => @collectible.joins(:cardset).where(cardsets: { standard: true }).count
		}

		@cardsets.each do |cardset|
			total[:cardsets][cardset.id] = {
				:rarities => [],
				:owned => @owned.where(cardset: cardset.id).count,
				:total => @collectible.where(cardset: cardset.id).count
			}
			@rarities.each do |rarity|
				total[:cardsets][cardset.id][:rarities][rarity.id] = {
					:owned => @owned.where(cardset: cardset.id, rarity: rarity.id).count,
					:total => @collectible.where(cardset: cardset.id, rarity: rarity.id).count
				}
			end
		end
		@rarities.each do |rarity|
			total[:rarities][rarity.id] = {
				:owned => @owned.where(rarity: rarity.id).count,
				:owned_std => @owned.joins(:cardset).where(rarity: rarity.id, cardsets: { standard: true }).count,
				:total => @collectible.where(rarity: rarity.id).count,
				:total_std => @collectible.joins(:cardset).where(rarity: rarity.id, cardsets: { standard: true }).count
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
