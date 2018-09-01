class UpdateCardclassesHeroCard < ActiveRecord::Migration[5.1]
	def change
		change_table :cardclasses do |t|
			t.integer :card_id
		end
	end
end
