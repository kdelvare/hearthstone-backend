require 'nokogiri'

namespace :db do
	task populate: :environment do
		Rake::Task["db:populate_enums"].invoke
		Rake::Task["db:populate_cards"].invoke
	end

	task populate_enums: :environment do
		yk = Year.create(name: 'Year of the Kraken', name_fr: 'Année du Kraken', standard: false)
		ym = Year.create(name: 'Year of the Mammoth', name_fr: 'Année du Mammouth', standard: true)
		yr = Year.create(name: 'Year of the Raven', name_fr: 'Année du Corbeau', standard: true)
		yd = Year.create(name: 'Year of the Dragon', name_fr: 'Année du Dragon', standard: false)
		Cardset.create(hs_id: 0, name: 'Invalid', name_fr: 'Invalide', collectible: false, standard: false)
		Cardset.create(hs_id: 1, name: 'Test temporary', name_fr: 'Test temporaire', collectible: false, standard: false)
		Cardset.create(hs_id: 2, name: 'Core', name_fr: 'Basique', collectible: true, standard: true)
		Cardset.create(hs_id: 3, name: 'Expert 1', name_fr: 'Classique', collectible: true, standard: true)
		Cardset.create(hs_id: 4, name: 'HOF', name_fr: 'Panthéon', collectible: true, standard: false)
		Cardset.create(hs_id: 5, name: 'Missions', name_fr: 'Missions', collectible: false, standard: false)
		Cardset.create(hs_id: 6, name: 'Demo', name_fr: 'Démo', collectible: false, standard: false)
		Cardset.create(hs_id: 7, name: 'None', name_fr: 'Aucun', collectible: false, standard: false)
		Cardset.create(hs_id: 8, name: 'Cheat', name_fr: 'Triche', collectible: false, standard: false)
		Cardset.create(hs_id: 9, name: 'Blank', name_fr: 'Vide', collectible: false, standard: false)
		Cardset.create(hs_id: 10, name: 'Debug sp', name_fr: 'Debug sp', collectible: false, standard: false)
		Cardset.create(hs_id: 11, name: 'Promo', name_fr: 'Promo', collectible: false, standard: false)
		Cardset.create(hs_id: 12, name: 'NAXX', name_fr: 'La malédiction de Naxxramas', collectible: true, standard: false)
		Cardset.create(hs_id: 13, name: 'GVG', name_fr: 'Gobelins et Gnomes', collectible: true, standard: false)
		Cardset.create(hs_id: 14, name: 'BRM', name_fr: 'Le Mont Rochenoire', collectible: true, standard: false)
		Cardset.create(hs_id: 15, name: 'TGT', name_fr: 'Le Grand Tournoi', collectible: true, standard: false)
		Cardset.create(hs_id: 16, name: 'Credits', name_fr: 'Crédits', collectible: false, standard: false)
		Cardset.create(hs_id: 17, name: 'Hero skins', name_fr: 'Portraits', collectible: false, standard: false)
		Cardset.create(hs_id: 18, name: 'TB', name_fr: 'TB', collectible: false, standard: false)
		Cardset.create(hs_id: 19, name: 'Slush', name_fr: 'Slush', collectible: false, standard: false)
		Cardset.create(hs_id: 20, name: 'LOE', name_fr: 'La Ligue des Explorateurs', collectible: true, standard: false)
		Cardset.create(hs_id: 21, name: 'OG', name_fr: 'Les Murmures des Dieux très anciens', collectible: true, standard: false, year_id: yk.id)
		Cardset.create(hs_id: 22, name: 'OG reserve', name_fr: '', collectible: false, standard: false)
		Cardset.create(hs_id: 23, name: 'KARA', name_fr: 'Une nuit à Karazhan', collectible: true, standard: false, year_id: yk.id)
		Cardset.create(hs_id: 24, name: 'KARA reserve', name_fr: 'KARA reserve', collectible: false, standard: false)
		Cardset.create(hs_id: 25, name: 'GANGS', name_fr: 'Main basse sur Gadgetzan', collectible: true, standard: false, year_id: yk.id)
		Cardset.create(hs_id: 26, name: 'GANGS reserve', name_fr: 'GANGS reserve', collectible: false, standard: false)
		Cardset.create(hs_id: 27, name: 'UNGORO', name_fr: 'Voyage au centre d’Un’Goro', collectible: true, standard: true, year_id: ym.id)
		Cardset.create(hs_id: 1001, name: 'Ice crown', name_fr: 'Chevaliers du Trône de glace', collectible: true, standard: true, year_id: ym.id)
		Cardset.create(hs_id: 1004, name: 'Lootapalooza', name_fr: 'Kobolds et catacombes', collectible: true, standard: true, year_id: ym.id)
		Cardset.create(hs_id: 1125, name: 'Gilneas', name_fr: 'Bois Maudit', collectible: true, standard: true, year_id: yr.id)
		Cardset.create(hs_id: 1127, name: 'Boomsday', name_fr: 'Projet Armageboum', collectible: true, standard: true, year_id: yr.id)
		Cardset.create(hs_id: 1129, name: 'Rastakhan', name_fr: 'Jeux de Rastakhan', collectible: true, standard: true, year_id: yr.id)
		Cardset.create(hs_id: 1130, name: 'Rise of Shadows', name_fr: 'L\'éveil des ombres', collectible: true, standard: false, year_id: yd.id)
		Cardclass.create(hs_id: 0, name: 'Invalid', name_fr: 'Invalide', collectible: false)
		Cardclass.create(hs_id: 1, name: 'Deathknight', name_fr: 'Chevalier de la mort', collectible: false)
		Cardclass.create(hs_id: 2, name: 'Druid', name_fr: 'Druide', collectible: true)
		Cardclass.create(hs_id: 3, name: 'Hunter', name_fr: 'Chasseur', collectible: true)
		Cardclass.create(hs_id: 4, name: 'Mage', name_fr: 'Mage', collectible: true)
		Cardclass.create(hs_id: 5, name: 'Paladin', name_fr: 'Paladin', collectible: true)
		Cardclass.create(hs_id: 6, name: 'Priest', name_fr: 'Prêtre', collectible: true)
		Cardclass.create(hs_id: 7, name: 'Rogue', name_fr: 'Voleur', collectible: true)
		Cardclass.create(hs_id: 8, name: 'Shaman', name_fr: 'Chaman', collectible: true)
		Cardclass.create(hs_id: 9, name: 'Warlock', name_fr: 'Démoniste', collectible: true)
		Cardclass.create(hs_id: 10, name: 'Warrior', name_fr: 'Guerrier', collectible: true)
		Cardclass.create(hs_id: 11, name: 'Dream', name_fr: 'Rêve', collectible: false)
		Cardclass.create(hs_id: 12, name: 'Neutral', name_fr: 'Neutre', collectible: true)
		Type.create(hs_id: 0, name: 'Invalid', name_fr: 'Invalide', collectible: true)
		Type.create(hs_id: 1, name: 'Game', name_fr: 'Jeu', collectible: true)
		Type.create(hs_id: 2, name: 'Player', name_fr: 'Joueur', collectible: true)
		Type.create(hs_id: 3, name: 'Hero', name_fr: 'Héros', collectible: true)
		Type.create(hs_id: 4, name: 'Minion', name_fr: 'Serviteur', collectible: true)
		Type.create(hs_id: 5, name: 'Spell', name_fr: 'Sort', collectible: true)
		Type.create(hs_id: 6, name: 'Enchantment', name_fr: 'Enchantement', collectible: true)
		Type.create(hs_id: 7, name: 'Weapon', name_fr: 'Arme', collectible: true)
		Type.create(hs_id: 8, name: 'Item', name_fr: 'Objet', collectible: true)
		Type.create(hs_id: 9, name: 'Token', name_fr: 'Jeton', collectible: true)
		Type.create(hs_id: 10, name: 'Hero power', name_fr: 'Pouvoir héroïque', collectible: true)
		Rarity.create(hs_id: 0, name: 'Invalid', name_fr: 'Invalide', collectible: false)
		Rarity.create(hs_id: 1, name: 'Common', name_fr: 'Commune', collectible: true)
		Rarity.create(hs_id: 2, name: 'Free', name_fr: 'Gratuite', collectible: true)
		Rarity.create(hs_id: 3, name: 'Rare', name_fr: 'Rare', collectible: true)
		Rarity.create(hs_id: 4, name: 'Epic', name_fr: 'Epique', collectible: true)
		Rarity.create(hs_id: 5, name: 'Legendary', name_fr: 'Légendaire', collectible: true)
	end

	task populate_cards: :environment do
		Card.delete_all
		@xml = File.open("CardDefs.xml") { |f| Nokogiri::XML(f) }
		@xml.xpath("//Entity").each do |card|
			collectible = card.xpath("Tag[@name='COLLECTIBLE']")
			if collectible.length > 0
				hs_id = card.xpath("@ID").to_s
				hs_card_id = card.xpath("@CardID").to_s
				name = card.xpath("Tag[@name='CARDNAME']/enUS").text
				name_fr = card.xpath("Tag[@name='CARDNAME']/frFR").text
				cardtext = card.xpath("Tag[@name='CARDTEXT_INHAND']/enUS").text
				cardtext_fr = card.xpath("Tag[@name='CARDTEXT_INHAND']/frFR").text
				flavor = card.xpath("Tag[@name='FLAVORTEXT']/enUS").text
				flavor_fr = card.xpath("Tag[@name='FLAVORTEXT']/frFR").text
				artist = card.xpath("Tag[@name='ARTISTNAME']/enUS").text
				cost = card.xpath("Tag[@name='COST']").xpath("@value").to_s.to_i
				health = card.xpath("Tag[@name='HEALTH']").xpath("@value").to_s
				atk = card.xpath("Tag[@name='ATK']").xpath("@value").to_s

				cardset = Cardset.find_by(hs_id: card.xpath("Tag[@name='CARD_SET']").xpath("@value").to_s)
				#puts hs_card_id + ': cardset not found' unless cardset
				cardset = Cardset.find_by(hs_id: 0) unless cardset
				cardclass = Cardclass.find_by(hs_id: card.xpath("Tag[@name='CLASS']").xpath("@value").to_s)
				puts hs_card_id + ': type not found' unless cardclass
				type = Type.find_by(hs_id: card.xpath("Tag[@name='CARDTYPE']").xpath("@value").to_s)
				puts hs_card_id + ': type not found' unless type
				rarity = Rarity.find_by(hs_id: card.xpath("Tag[@name='RARITY']").xpath("@value").to_s)
				puts hs_card_id + ': rarity not found' unless rarity

				card = Card.create(
					hs_id: hs_id, hs_card_id: hs_card_id, name: name, name_fr: name_fr, cardtext: cardtext, cardtext_fr: cardtext_fr,
					flavor: flavor, flavor_fr: flavor_fr, artist: artist, cost: cost, health: health, atk: atk,
					cardset_id: cardset.id, cardclass_id: cardclass.id, type_id: type.id, rarity_id: rarity.id
				)
				#puts 'Created card ' + name
				puts 'Card creation error' unless card
			end
		end
	end

	task dedupe_cards: :environment do
		grouped = Card.all.group_by(&:hs_id)
		grouped.values.each do |duplicates|
			keep_first = duplicates.shift
			duplicates.each { |duplicate| puts 'Duplicate ' + duplicate.inspect } if duplicates.count > 0
			#duplicates.each { |duplicate| duplicate.destroy } if duplicates.count > 0
		end
	end

	task dedupe_collections: :environment do
		grouped = Collection.all.group_by{ |collection| [collection.user_id, collection.card_id] }
		grouped.values.each do |duplicates|
			keep_first = duplicates.shift
			duplicates.each { |duplicate| puts 'Duplicate ' + duplicate.inspect } if duplicates.count > 0
			#duplicates.each { |duplicate| duplicate.destroy } if duplicates.count > 0
		end
	end

	task compute_completion: :environment do
		collections = Collection.all
		collections.each do |collection|
			max_number = (collection.card.rarity.name == "Legendary") ? 1 : 2
			completion = (collection.number > max_number) ? max_number : collection.number
			collection.update(completion: completion, golden: 0)
		end
	end

	task populate_edhel: :environment do
		User.create(name: 'edhel')
	end
end
