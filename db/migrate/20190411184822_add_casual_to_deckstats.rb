class AddCasualToDeckstats < ActiveRecord::Migration[5.1]
	def change
		change_table :deckstats do |t|
			t.integer :win_casual
			t.integer :loose_casual
		end
	end
end
