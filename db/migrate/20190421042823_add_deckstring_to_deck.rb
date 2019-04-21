class AddDeckstringToDeck < ActiveRecord::Migration[5.1]
  def change
	change_table :decks do |t|
		t.string :deckstring
	end
  end
end
