class CreateTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :types, id: false do |t|
      t.primary_key :hs_id
      t.string :name
    end
  end
end
