class AddCardsetToDeckgroups < ActiveRecord::Migration[5.1]
	def change
		change_table :deckgroups do |t|
			t.integer :cardset_id
		end
	end
end
