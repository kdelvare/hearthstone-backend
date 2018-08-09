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
end
