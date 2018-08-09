require 'nokogiri'

namespace :db do
	task populate: :environment do
		Rake::Task["db:populate_enums"].invoke
		Rake::Task["db:populate_cards"].invoke
	end

	task populate_enums: :environment do
		Cardset.create(hs_id: 0, name: 'Invalid')
		Cardset.create(hs_id: 1, name: 'Test temporary')
		Cardset.create(hs_id: 2, name: 'Core')
		Cardset.create(hs_id: 3, name: 'Expert 1')
		Cardset.create(hs_id: 4, name: 'HOF')
		Cardset.create(hs_id: 5, name: 'Missions')
		Cardset.create(hs_id: 6, name: 'Demo')
		Cardset.create(hs_id: 7, name: 'None')
		Cardset.create(hs_id: 8, name: 'Cheat')
		Cardset.create(hs_id: 9, name: 'Blank')
		Cardset.create(hs_id: 10, name: 'Debug sp')
		Cardset.create(hs_id: 11, name: 'Promo')
		Cardset.create(hs_id: 12, name: 'NAXX')
		Cardset.create(hs_id: 13, name: 'GVG')
		Cardset.create(hs_id: 14, name: 'BRM')
		Cardset.create(hs_id: 15, name: 'TGT')
		Cardset.create(hs_id: 16, name: 'Credits')
		Cardset.create(hs_id: 17, name: 'Hero skins')
		Cardset.create(hs_id: 18, name: 'TB')
		Cardset.create(hs_id: 19, name: 'Slush')
		Cardset.create(hs_id: 20, name: 'LOE')
		Cardset.create(hs_id: 21, name: 'OG')
		Cardset.create(hs_id: 22, name: 'OG reserve')
		Cardset.create(hs_id: 23, name: 'KARA')
		Cardset.create(hs_id: 24, name: 'KARA reserve')
		Cardset.create(hs_id: 25, name: 'GANGS')
		Cardset.create(hs_id: 26, name: 'GANGS reserve')
		Cardset.create(hs_id: 27, name: 'UNGORO')
		Cardset.create(hs_id: 1001, name: 'Ice crown')
		Cardset.create(hs_id: 1004, name: 'Lootapalooza')
		Cardclass.create(hs_id: 0, name: 'Invalid')
		Cardclass.create(hs_id: 1, name: 'Deathknight')
		Cardclass.create(hs_id: 2, name: 'Druid')
		Cardclass.create(hs_id: 3, name: 'Hunter')
		Cardclass.create(hs_id: 4, name: 'Mage')
		Cardclass.create(hs_id: 5, name: 'Paladin')
		Cardclass.create(hs_id: 6, name: 'Priest')
		Cardclass.create(hs_id: 7, name: 'Rogue')
		Cardclass.create(hs_id: 8, name: 'Shaman')
		Cardclass.create(hs_id: 9, name: 'Warlock')
		Cardclass.create(hs_id: 10, name: 'Warrior')
		Cardclass.create(hs_id: 11, name: 'Dream')
		Cardclass.create(hs_id: 12, name: 'Neutral')
		Type.create(hs_id: 0, name: 'Invalid')
		Type.create(hs_id: 1, name: 'Game')
		Type.create(hs_id: 2, name: 'Player')
		Type.create(hs_id: 3, name: 'Hero')
		Type.create(hs_id: 4, name: 'Minion')
		Type.create(hs_id: 5, name: 'Spell')
		Type.create(hs_id: 6, name: 'Enchantment')
		Type.create(hs_id: 7, name: 'Weapon')
		Type.create(hs_id: 8, name: 'Item')
		Type.create(hs_id: 9, name: 'Token')
		Type.create(hs_id: 10, name: 'Hero power')
		Rarity.create(hs_id: 0, name: 'Invalid')
		Rarity.create(hs_id: 1, name: 'Common')
		Rarity.create(hs_id: 2, name: 'Free')
		Rarity.create(hs_id: 3, name: 'Rare')
		Rarity.create(hs_id: 4, name: 'Epic')
		Rarity.create(hs_id: 5, name: 'Legendary')
	end

	task populate_cards: :environment do
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
				cost = card.xpath("Tag[@name='COST']").xpath("@value").to_s
				health = card.xpath("Tag[@name='HEALTH']").xpath("@value").to_s
				atk = card.xpath("Tag[@name='ATK']").xpath("@value").to_s

				cardset = Cardset.find_by(hs_id: card.xpath("Tag[@name='CARD_SET']").xpath("@value").to_s)
				puts hs_card_id + ': cardset not found' unless cardset
				cardclass = Cardclass.find_by(hs_id: card.xpath("Tag[@name='CLASS']").xpath("@value").to_s)
				puts hs_card_id + ': type not found' unless cardclass
				type = Type.find_by(hs_id: card.xpath("Tag[@name='CARDTYPE']").xpath("@value").to_s)
				puts hs_card_id + ': type not found' unless type
				rarity = Rarity.find_by(hs_id: card.xpath("Tag[@name='RARITY']").xpath("@value").to_s)
				puts hs_card_id + ': rarity not found' unless rarity

				card = Card.create(hs_id: hs_id, hs_card_id: hs_card_id, name: name, name_fr: name_fr, cardtext: cardtext, cardtext_fr: cardtext_fr, flavor: flavor, flavor_fr: flavor_fr, artist: artist, cost: cost, health: health, atk: atk)
				puts 'Created card ' + name
				puts 'Card creation error' unless card
			end
		end
	end

	task populate_edhel: :environment do
		Player.create(name: 'edhel')
	end
end
