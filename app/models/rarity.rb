class Rarity < ActiveRecord::Base
  self.primary_key = 'hs_id'

  def create
    respond_with Rarity.create(rarity_params)
  end

  private

  def rarity_params
    params.require(:rarity).permit(:hs_id, :name)
  end
end
