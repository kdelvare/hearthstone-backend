class CreateCards < ActiveRecord::Migration[5.1]
  def change
    create_table :cards, id: false do |t|
      t.primary_key :hs_id
      t.string :hs_card_id
      t.string :name
      t.string :name_fr
      t.string :cardtext
      t.string :cardtext_fr
      t.text :flavor
      t.text :flavor_fr
      t.string :artist
      t.integer :cost
      t.integer :health
      t.integer :atk
    end
  end
end
