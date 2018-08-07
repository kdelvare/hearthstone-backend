class Cardset < ActiveRecord::Base
  self.primary_key = 'hs_id'

  def create
    respond_with Cardset.create(cardset_params)
  end

  private

  def cardset_params
    params.require(:cardset).permit(:hs_id, :name)
  end
end
