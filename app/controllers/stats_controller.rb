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
		completion = {
			:cardsets => [],
			:rarities => [],
			:owned => 0,
			:owned_std => 0,
			:total => 0,
			:total_std => 0
		}

		@cardsets.each do |cardset|
			total[:cardsets][cardset.id] = {
				:rarities => [],
				:owned => @owned.where(cardset: cardset.id).count,
				:total => @collectible.where(cardset: cardset.id).count
			}
			completion[:cardsets][cardset.id] = {
				:rarities => [],
				:owned => 0,
				:total => 0
			}
			@rarities.each do |rarity|
				total[:cardsets][cardset.id][:rarities][rarity.id] = {
					:owned => @owned.where(cardset: cardset.id, rarity: rarity.id).count,
					:total => @collectible.where(cardset: cardset.id, rarity: rarity.id).count
				}
				completion[:cardsets][cardset.id][:rarities][rarity.id] = {
					:owned => 0,
					:total => 0
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
				:owned => 0,
				:owned_std => 0,
				:total => 0,
				:total_std => 0
			}
		end

		@collectible.each do |card|
			max_number = (card.rarity.name == "Legendary") ? 1 : 2
			owned = card.collections.where(user_id: params[:user]).first
			owned_number = owned ? owned.number : 0
			owned_number = max_number if owned_number > max_number

			completion[:total] += max_number
			completion[:owned] += owned_number
			completion[:cardsets][card.cardset.id][:total] += max_number
			completion[:cardsets][card.cardset.id][:owned] += owned_number
			completion[:cardsets][card.cardset.id][:rarities][card.rarity.id][:total] += max_number
			completion[:cardsets][card.cardset.id][:rarities][card.rarity.id][:owned] += owned_number
			completion[:rarities][card.rarity.id][:total] += max_number
			completion[:rarities][card.rarity.id][:owned] += owned_number
			if (card.cardset.standard)
				completion[:total_std] += max_number
				completion[:owned_std] += owned_number
				completion[:rarities][card.rarity.id][:total_std] += max_number
				completion[:rarities][card.rarity.id][:owned_std] += owned_number
			end

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
