class CreateDeckstats < ActiveRecord::Migration[5.1]
	def change
		create_table :deckstats do |t|
			t.integer :deck_id
			t.integer :user_id
			t.integer :win
			t.integer :loose
		end
	end
end
