class AddUserToDeck < ActiveRecord::Migration[5.1]
	def change
		change_table :decks do |t|
			t.integer :user_id
		end
	end
end
