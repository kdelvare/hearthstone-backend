require 'nokogiri'

namespace :test do
	task:hello do
		puts 'Hello'
	end

	task:noko do
		@xml = File.open("CardDefs.xml") { |f| Nokogiri::XML(f) }
		puts 'Nokogiri OK'
	end
end
