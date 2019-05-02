class AddCommentToDeck < ActiveRecord::Migration[5.1]
    def change
		change_table :decks do |t|
			t.text :comment
		end
	end
end
