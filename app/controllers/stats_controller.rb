class StatsController < JSONAPI::ResourceController
	def index
		@collectible = Card.where.not(type_id: 3).or(Card.where("cost > ?", 0)) # filter basic Hero cards
		@owned = Card.includes(:collections).where(collections: { user_id: params[:user] }) if params[:user].present?
		@cardsets = Cardset.where(collectible: true)
		@cardclasses = Cardclass.where(collectible: true)
		@rarities = Rarity.where(collectible: true)

		total = {
			:cardsets => [],
			:cardclasses => [],
			:rarities => [],
			:owned => @owned.count,
			:owned_std => @owned.joins(:cardset).where(cardsets: { standard: true }).count,
			:total => @collectible.count,
			:total_std => @collectible.joins(:cardset).where(cardsets: { standard: true }).count
		}
		completion = {
			:cardsets => [],
			:cardclasses => [],
			:rarities => [],
			:owned => @owned.sum(:completion),
			:owned_std => @owned.joins(:cardset).where(cardsets: { standard: true }).sum(:completion),
			:total => @collectible.count +
				@collectible.where.not(rarity: 5).count,
			:total_std => @collectible.joins(:cardset).where(cardsets: { standard: true }).count +
				@collectible.joins(:cardset).where(cardsets: { standard: true }).where.not(rarity: 5).count
		}

		@cardsets.each do |cardset|
			total[:cardsets][cardset.id] = {
				:rarities => [],
				:owned => @owned.where(cardset: cardset.id).count,
				:total => @collectible.where(cardset: cardset.id).count
			}
			completion[:cardsets][cardset.id] = {
				:rarities => [],
				:owned => @owned.where(cardset: cardset.id).sum(:completion),
				:total => @collectible.where(cardset: cardset.id).count +
					@collectible.where(cardset: cardset.id).where.not(rarity: 5).count
			}
			@rarities.each do |rarity|
				total[:cardsets][cardset.id][:rarities][rarity.id] = {
					:owned => @owned.where(cardset: cardset.id, rarity: rarity.id).count,
					:total => @collectible.where(cardset: cardset.id, rarity: rarity.id).count
				}
				completion[:cardsets][cardset.id][:rarities][rarity.id] = {
					:owned => @owned.where(cardset: cardset.id, rarity: rarity.id).sum(:completion),
					:total => @collectible.where(cardset: cardset.id, rarity: rarity.id).count +
						@collectible.where(cardset: cardset.id, rarity: rarity.id).where.not(rarity: 5).count
				}
			end
		end
		@cardclasses.each do |cardclass|
			total[:cardclasses][cardclass.id] = {
				:rarities => [],
				:owned => @owned.where(cardclass: cardclass.id).count,
				:owned_std => @owned.joins(:cardset).where(cardclass: cardclass.id, cardsets: { standard: true }).count,
				:total => @collectible.where(cardclass: cardclass.id).count,
				:total_std => @collectible.joins(:cardset).where(cardclass: cardclass.id, cardsets: { standard: true }).count
			}
			completion[:cardclasses][cardclass.id] = {
				:rarities => [],
				:owned => @owned.where(cardclass: cardclass.id).sum(:completion),
				:owned_std => @owned.joins(:cardset).where(cardclass: cardclass.id, cardsets: { standard: true }).sum(:completion),
				:total => @collectible.where(cardclass: cardclass.id).count +
					@collectible.where(cardclass: cardclass.id).where.not(rarity: 5).count,
				:total_std => @collectible.joins(:cardset).where(cardclass: cardclass.id, cardsets: { standard: true }).count +
					@collectible.joins(:cardset).where(cardclass: cardclass.id, cardsets: { standard: true }).where.not(rarity: 5).count
			}
			@rarities.each do |rarity|
				total[:cardclasses][cardclass.id][:rarities][rarity.id] = {
					:owned => @owned.where(cardclass: cardclass.id, rarity: rarity.id).count,
					:owned_std => @owned.joins(:cardset).where(cardclass: cardclass.id, rarity: rarity.id, cardsets: { standard: true }).count,
					:total => @collectible.where(cardclass: cardclass.id, rarity: rarity.id).count,
					:total_std => @collectible.joins(:cardset).where(cardclass: cardclass.id, rarity: rarity.id, cardsets: { standard: true }).count
				}
				completion[:cardclasses][cardclass.id][:rarities][rarity.id] = {
					:owned => @owned.where(cardclass: cardclass.id, rarity: rarity.id).sum(:completion),
					:owned_std => @owned.joins(:cardset).where(cardclass: cardclass.id, rarity: rarity.id, cardsets: { standard: true }).sum(:completion),
					:total => @collectible.where(cardclass: cardclass.id, rarity: rarity.id).count +
						@collectible.where(cardclass: cardclass.id, rarity: rarity.id).where.not(rarity: 5).count,
					:total_std => @collectible.joins(:cardset).where(cardclass: cardclass.id, rarity: rarity.id, cardsets: { standard: true }).count +
						@collectible.joins(:cardset).where(cardclass: cardclass.id, rarity: rarity.id, cardsets: { standard: true }).where.not(rarity: 5).count
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
			completion[:rarities][rarity.id] = {
				:owned => @owned.where(rarity: rarity.id).sum(:completion),
				:owned_std => @owned.joins(:cardset).where(rarity: rarity.id, cardsets: { standard: true }).sum(:completion),
				:total => @collectible.where(rarity: rarity.id).count +
					@collectible.where(rarity: rarity.id).where.not(rarity: 5).count,
				:total_std => @collectible.joins(:cardset).where(rarity: rarity.id, cardsets: { standard: true }).count +
					@collectible.joins(:cardset).where(rarity: rarity.id, cardsets: { standard: true }).where.not(rarity: 5).count
			}
		end

		render json: {
			data: {
				id: 1,
				type: 'stat',
				attributes: {
					total: total,
					completion: completion
				}
			}
		}
	end
end
