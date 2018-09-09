class CreateDeckgroups < ActiveRecord::Migration[5.1]
	def change
		create_table :deckgroups do |t|
			t.string :name
			t.string :url
		end

		change_table :decks do |t|
			t.integer :deckgroup_id
		end
	end
end
