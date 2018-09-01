class CreateDecks < ActiveRecord::Migration[5.1]
	def change
		create_table :decks do |t|
			t.string :name
			t.string :url
			t.integer :cardclass_id
		end
	end
end
