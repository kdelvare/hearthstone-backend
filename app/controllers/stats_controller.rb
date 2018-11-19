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
		standard = params[:standard] == "true"

		@wanted_base = standard ? @wanted_std : @wanted
		@collec_base = standard ? @collec_std : @collectible
		completion = {
			:cardsets => [],
			:cardclasses => [],
			:rarities => [],
			:wanted => @wanted_base.group(:card_id).length + @wanted_base.where(wantedcards: { number: 2 }).group(:card_id).length,
			:owned => standard ? @owned_std.sum(:completion) : @owned.sum(:completion),
			:total => @collec_base.count + @collec_base.where.not(rarity: 5).count
		}
		total = {
			:cardsets => [],
			:cardclasses => [],
			:rarities => [],
			:owned => standard ? @owned_std.count : @owned.count,
			:total => standard ? @collec_std.count : @collectible.count
		} if params[:fullStats]
		extra = {
			:normal => {
				:rarities => [],
				:total => 0
			},
			:golden => {
				:rarities => [],
				:total => 0
			}
		} if params[:fullStats]

		@cardsets.each do |cardset|
			if (!standard || cardset.standard)
				@wanted_base = @wanted.where(cardset: cardset.id)
				@collec_base = @collectible.where(cardset: cardset.id)
				completion[:cardsets][cardset.id] = {
					:rarities => [],
					:wanted => @wanted_base.group(:card_id).length + @wanted_base.where(wantedcards: { number: 2 }).group(:card_id).length,
					:owned => @owned.where(cardset: cardset.id).sum(:completion),
					:total => @collec_base.count + @collec_base.where.not(rarity: 5).count
				}
				total[:cardsets][cardset.id] = {
					:rarities => [],
					:owned => @owned.where(cardset: cardset.id).count,
					:total => @collectible.where(cardset: cardset.id).count
				} if params[:fullStats]
				@rarities.each do |rarity|
					@wanted_base = @wanted.where(cardset: cardset.id, rarity: rarity.id)
					@collec_base = @collectible.where(cardset: cardset.id, rarity: rarity.id)
					completion[:cardsets][cardset.id][:rarities][rarity.id] = {
						:wanted => @wanted_base.group(:card_id).length + @wanted_base.where(wantedcards: { number: 2 }).group(:card_id).length,
						:owned => @owned.where(cardset: cardset.id, rarity: rarity.id).sum(:completion),
						:total => @collec_base.count + @collec_base.where.not(rarity: 5).count
					}
					total[:cardsets][cardset.id][:rarities][rarity.id] = {
						:owned => @owned.where(cardset: cardset.id, rarity: rarity.id).count,
						:total => @collectible.where(cardset: cardset.id, rarity: rarity.id).count
					} if params[:fullStats]
				end
			end
		end

		@rarities.each do |rarity|
			@wanted_base = standard ? @wanted_std.where(rarity: rarity.id) : @wanted.where(rarity: rarity.id)
			@collec_base = standard ? @collec_std.where(rarity: rarity.id) : @collectible.where(rarity: rarity.id)
			completion[:rarities][rarity.id] = {
				:wanted => @wanted_base.group(:card_id).length + @wanted_base.where(wantedcards: { number: 2 }).group(:card_id).length,
				:owned => standard ? @owned_std.where(rarity: rarity.id).sum(:completion) : @owned.where(rarity: rarity.id).sum(:completion),
				:total => @collec_base.count + @collec_base.where.not(rarity: 5).count
			}

			if params[:fullStats]
				total[:rarities][rarity.id] = {
					:owned => standard ? @owned_std.where(rarity: rarity.id).count : @owned.where(rarity: rarity.id).count,
					:total => standard ? @collec_std.where(rarity: rarity.id).count : @collectible.where(rarity: rarity.id).count
				}
				extra[:normal][:rarities][rarity.id] = 0
				extra[:golden][:rarities][rarity.id] = 0
				@extra = @owned.where(rarity: rarity.id).where(rarity.id == 5 ? "collections.number > 1" : "collections.number > 2")
				@extra.each do |extracard|
					collection = extracard.collections.find_by(user_id: params[:user])
					extra_number = collection.number - (rarity.id == 5 ? 1 : 2)
					extra_normal = extra_number > collection.golden ? extra_number - collection.golden : 0
					extra[:normal][:rarities][rarity.id] += extra_normal
					extra[:normal][:total] += extra_normal
					extra[:golden][:rarities][rarity.id] += extra_number - extra_normal
					extra[:golden][:total] += extra_number - extra_normal
				end
			end
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
					completion: completion,
					extra: extra
				}
			}
		}
	end
end
