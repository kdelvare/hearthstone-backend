class StatsController < JSONAPI::ResourceController
	def index
		@collectible = Card.where.not(type_id: 3).or(Card.where("cost > ?", 0)) # filter basic Hero cards
		@collec_std = @collectible.joins(:cardset).where(cardsets: { standard: true })
		@wanted = Card.includes(:wantedcards).where(wantedcards: { user_id: params[:user] })
		@wanted_std = @wanted.joins(:cardset).where(cardsets: { standard: true })
		@owned = Card.includes(:collections).where(collections: { user_id: params[:user] })
		@owned_std =  @owned.joins(:cardset).where(cardsets: { standard: true })
		@cardsets = Cardset.where(collectible: true)
		@cardclasses = Cardclass.where(collectible: true)
		@rarities = Rarity.where(collectible: true)
		standard = params[:standard].present?

		completion = {
			:cardsets => [],
			:cardclasses => [],
			:rarities => [],
			:wanted => standard ? @wanted_std.sum(:number) : @wanted.sum(:number),
			:owned => standard ? @owned_std.sum(:completion) : @owned.sum(:completion),
			:total => standard ? @collec_std.count + @collec_std.where.not(rarity: 5).count : @collectible.count + @collectible.where.not(rarity: 5).count
		}
		total = {
			:cardsets => [],
			:cardclasses => [],
			:rarities => [],
			:owned => standard ? @owned_std.count : @owned.count,
			:total => standard ? @collec_std.count : @collectible.count
		} if params[:fullStats]

		@cardsets.each do |cardset|
			if (!standard || cardset.standard)
				completion[:cardsets][cardset.id] = {
					:rarities => [],
					:wanted => @wanted.where(cardset: cardset.id).sum(:number),
					:owned => @owned.where(cardset: cardset.id).sum(:completion),
					:total => @collectible.where(cardset: cardset.id).count + @collectible.where(cardset: cardset.id).where.not(rarity: 5).count
				}
				total[:cardsets][cardset.id] = {
					:rarities => [],
					:owned => @owned.where(cardset: cardset.id).count,
					:total => @collectible.where(cardset: cardset.id).count
				} if params[:fullStats]
				@rarities.each do |rarity|
					completion[:cardsets][cardset.id][:rarities][rarity.id] = {
						:wanted => @wanted.where(cardset: cardset.id, rarity: rarity.id).sum(:number),
						:owned => @owned.where(cardset: cardset.id, rarity: rarity.id).sum(:completion),
						:total => @collectible.where(cardset: cardset.id, rarity: rarity.id).count +
							@collectible.where(cardset: cardset.id, rarity: rarity.id).where.not(rarity: 5).count
					}
					total[:cardsets][cardset.id][:rarities][rarity.id] = {
						:owned => @owned.where(cardset: cardset.id, rarity: rarity.id).count,
						:total => @collectible.where(cardset: cardset.id, rarity: rarity.id).count
					} if params[:fullStats]
				end
			end
		end

		@rarities.each do |rarity|
			completion[:rarities][rarity.id] = {
				:wanted => standard ? @wanted_std.where(rarity: rarity.id).sum(:number) : @wanted.where(rarity: rarity.id).sum(:number),
				:owned => standard ? @owned_std.where(rarity: rarity.id).sum(:completion) : @owned.where(rarity: rarity.id).sum(:completion),
				:total => standard ?
					@collec_std.where(rarity: rarity.id).count + @collec_std.where(rarity: rarity.id).where.not(rarity: 5).count :
					@collectible.where(rarity: rarity.id).count + @collectible.where(rarity: rarity.id).where.not(rarity: 5).count
			}
			total[:rarities][rarity.id] = {
				:owned => standard ? @owned_std.where(rarity: rarity.id).count : @owned.where(rarity: rarity.id).count,
				:total => standard ? @collec_std.where(rarity: rarity.id).count : @collectible.where(rarity: rarity.id).count
			} if params[:fullStats]
		end

		if params[:fullStats]
			@cardclasses.each do |cardclass|
				completion[:cardclasses][cardclass.id] = {
					:rarities => [],
					:owned => standard ? @owned_std.where(cardclass: cardclass.id).sum(:completion) : @owned.where(cardclass: cardclass.id).sum(:completion),
					:total => standard ?
						@collec_std.where(cardclass: cardclass.id).count + @collec_std.where(cardclass: cardclass.id).where.not(rarity: 5).count :
						@collectible.where(cardclass: cardclass.id).count + @collectible.where(cardclass: cardclass.id).where.not(rarity: 5).count
				}
				total[:cardclasses][cardclass.id] = {
					:rarities => [],
					:owned => standard ? @owned_std.where(cardclass: cardclass.id).count : @owned.where(cardclass: cardclass.id).count,
					:total => standard ? @collec_std.where(cardclass: cardclass.id).count : @collectible.where(cardclass: cardclass.id).count
				} if params[:fullStats]
				@rarities.each do |rarity|
					completion[:cardclasses][cardclass.id][:rarities][rarity.id] = {
						:owned => standard ? @owned_std.where(cardclass: cardclass.id, rarity: rarity.id).sum(:completion) : @owned.where(cardclass: cardclass.id, rarity: rarity.id).sum(:completion),
						:total => standard ?
							@collec_std.where(cardclass: cardclass.id, rarity: rarity.id).count + @collec_std.where(cardclass: cardclass.id, rarity: rarity.id).where.not(rarity: 5).count :
							@collectible.where(cardclass: cardclass.id, rarity: rarity.id).count + @collectible.where(cardclass: cardclass.id, rarity: rarity.id).where.not(rarity: 5).count
					}
					total[:cardclasses][cardclass.id][:rarities][rarity.id] = {
						:owned => standard ? @owned_std.where(cardclass: cardclass.id, rarity: rarity.id).count : @owned.where(cardclass: cardclass.id, rarity: rarity.id).count,
						:total => standard ? @collec_std.where(cardclass: cardclass.id, rarity: rarity.id).count : @collectible.where(cardclass: cardclass.id, rarity: rarity.id).count
					} if params[:fullStats]
				end
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
