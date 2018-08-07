class Player < ActiveRecord::Base
  def create
    respond_with Player.create(player_params)
  end

  private

  def rarity_params
    params.require(:player).permit(:name)
  end
end
