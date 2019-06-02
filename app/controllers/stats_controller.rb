class StatsController < JSONAPI::ResourceController
	def index
		@collectible = Card.where.not(type_id: 3).or(Card.where("cost > ?", 0)) # filter basic Hero cards
		@collec_std = @collectible.joins(:cardset).where(cardsets: { standard: true })
		@wanted = Card.includes(:wantedcards).where(wantedcards: { user_id: params[:user] })
		@wanted_std = @wanted.joins(:cardset).where(cardsets: { standard: true })
		@owned = Card.includes(:collections).where(collections: { user_id: params[:user] })
		@owned_std =  @owned.joins(:cardset).where(cardsets: { standard: true })
		@missing = Card.joins("LEFT JOIN collections ON collections.card_id = cards.hs_id AND collections.user_id = #{params[:user]}").where("(collections.number = 1 AND cards.rarity_id <> 5) OR collections.id IS NULL")
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
		extrahs = {
			:normal => {
				:rarities => [],
				:total => 0
			},
			:golden => {
				:rarities => [],
				:total => 0
			}
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
				@rarities.each do |rarity|
					@wanted_base = @wanted.where(cardset: cardset.id, rarity: rarity.id)
					@missing_base = @missing.where(cardset: cardset.id, rarity: rarity.id)
					@collec_base = @collectible.where(cardset: cardset.id, rarity: rarity.id)
					completion[:cardsets][cardset.id][:rarities][rarity.id] = {
						:wanted => @wanted_base.group(:card_id).length + @wanted_base.where(wantedcards: { number: 2 }).group(:card_id).length,
						:wanted_uniq => @wanted_base.group(:card_id).length,
						:owned => @owned.where(cardset: cardset.id, rarity: rarity.id).sum(:completion),
						:missing => @missing_base.where(cardset: cardset.id, rarity: rarity.id).count,
						:total => @collec_base.count + @collec_base.where.not(rarity: 5).count,
						:unique => @collec_base.count
					}
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
				extrahs[:normal][:rarities][rarity.id] = 0
				extrahs[:golden][:rarities][rarity.id] = 0
				extra[:normal][:rarities][rarity.id] = 0
				extra[:golden][:rarities][rarity.id] = 0
				@extra = @owned.where(rarity: rarity.id).where(rarity.id == 5 ? "collections.number > 1" : "collections.number > 2")
				@extra.each do |extracard|
					collection = extracard.collections.find_by(user_id: params[:user])
					extra_total = collection.number - (rarity.id == 5 ? 1 : 2)
					extra_golden = collection.golden - (rarity.id == 5 ? 1 : 2)
					extra_golden = 0 if extra_golden < 0
					extra_normal = extra_total - collection.golden
					extrahs[:normal][:rarities][rarity.id] += extra_normal
					extrahs[:normal][:total] += extra_normal
					extrahs[:golden][:rarities][rarity.id] += extra_golden
					extrahs[:golden][:total] += extra_golden
					extra[:normal][:rarities][rarity.id] += extra_normal
					extra[:normal][:total] += extra_normal
					if rarity.id != 2
						extra[:golden][:rarities][rarity.id] += extra_total - extra_normal
						extra[:golden][:total] += extra_total - extra_normal
					end
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
				@rarities.each do |rarity|
					completion[:cardclasses][cardclass.id][:rarities][rarity.id] = {
						:owned => standard ? @owned_std.where(cardclass: cardclass.id, rarity: rarity.id).sum(:completion) : @owned.where(cardclass: cardclass.id, rarity: rarity.id).sum(:completion),
						:total => standard ?
							@collec_std.where(cardclass: cardclass.id, rarity: rarity.id).count + @collec_std.where(cardclass: cardclass.id, rarity: rarity.id).where.not(rarity: 5).count :
							@collectible.where(cardclass: cardclass.id, rarity: rarity.id).count + @collectible.where(cardclass: cardclass.id, rarity: rarity.id).where.not(rarity: 5).count
					}
				end
			end
		end

		render json: {
			data: {
				id: 1,
				type: 'stat',
				attributes: {
					completion: completion,
					extrahs: extrahs,
					extra: extra
				}
			}
		}
	end
end
