class Cardclass < ActiveRecord::Base
  self.primary_key = 'hs_id'

  def create
    respond_with Cardclass.create(cardclass_params)
  end

  private

  def cardclass_params
    params.require(:cardclass).permit(:hs_id, :name)
  end
end
