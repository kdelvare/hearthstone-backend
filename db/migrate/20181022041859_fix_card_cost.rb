class FixCardCost < ActiveRecord::Migration[5.1]
	def change
		Card.find_each do |card|
			if (!card.cost && card.type_id != 3) # only fix non-hero cards
				card.cost = 0
				card.save!
			end
		end
	end
end
