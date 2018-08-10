class ModifyEnums < ActiveRecord::Migration[5.1]
	def change
		change_table :cardsets do |t|
			t.string :name_fr
			t.boolean :collectible
			t.boolean :standard
		end

		change_table :cardclasses do |t|
			t.string :name_fr
			t.boolean :collectible
		end

		change_table :types do |t|
			t.string :name_fr
			t.boolean :collectible
		end

		change_table :rarities do |t|
			t.string :name_fr
			t.boolean :collectible
		end
	end
end
