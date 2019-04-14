class FixDeckstatsColumnNames < ActiveRecord::Migration[5.1]
  def change
	change_table :deckstats do |t|
		t.rename :win_casual, :wincasual
		t.rename :loose_casual, :loosecasual
	end
  end
end
