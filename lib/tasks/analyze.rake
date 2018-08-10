require 'nokogiri'

namespace :xml do
	task readtags: :environment do
		@xml = File.open("CardDefs.xml") { |f| Nokogiri::XML(f) }
		@tags = []
		@values = {}
		@xml.xpath("//Tag[@type='Int']").each do |tag|
			name = tag.xpath("@name").to_s
			value = tag.xpath("@value").to_s
			if !@tags.include?(name)
				@tags << name
				@values[name] = []
				puts "New tag: " + name
			end
			if !@values[name].include?(value)
				@values[name] << value
				puts "New value for tag " + name + ": " + value
			end
		end
		puts @values
	end

	task missing_enums: :environment do
		@xml = File.open("CardDefs.xml") { |f| Nokogiri::XML(f) }
		#@missing = { 'Cardset': [], 'Cardclass': [], 'Type': [], 'Rarity': [] }
		@xml.xpath("//Entity").each do |card|
			collectible = card.xpath("Tag[@name='COLLECTIBLE']")
			if collectible.length > 0
				value = card.xpath("Tag[@name='CARD_SET']").xpath("@value").to_s
				puts 'Cardset not found: ' + value unless Cardset.find_by(hs_id: value)

				value = card.xpath("Tag[@name='CLASS']").xpath("@value").to_s
				puts 'Cardclass not found: ' + value unless Cardclass.find_by(hs_id: value)

				value = card.xpath("Tag[@name='CARDTYPE']").xpath("@value").to_s
				puts 'Type not found: ' + value unless Type.find_by(hs_id: value)

				value = card.xpath("Tag[@name='RARITY']").xpath("@value").to_s
				puts 'Rarity not found: ' + value unless Rarity.find_by(hs_id: value)
			end
		end
	end
end
