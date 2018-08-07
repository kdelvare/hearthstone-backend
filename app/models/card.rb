class Card < ActiveRecord::Base
  self.primary_key = 'hs_id'

  def create
    respond_with Card.create(card_params)
  end

  private

  def card_params
    params.require(:card).permit(:hs_id, :hs_card_id, :name, :name_fr, :cardtext, :cardtext_fr, :flavor, :flavor_fr, :artist, :cost, :health, :atk)
  end
end
