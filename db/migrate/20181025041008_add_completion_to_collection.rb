class AddCompletionToCollection < ActiveRecord::Migration[5.1]
	def change
		change_table :collections do |t|
			t.integer :completion
		end
	end
end
