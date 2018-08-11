class UpdateCardsRelationships < ActiveRecord::Migration[5.1]
	def change
		change_table :cards do |t|
			t.integer :cardset_id
			t.integer :cardclass_id
			t.integer :type_id
			t.integer :rarity_id
		end
	end
end
