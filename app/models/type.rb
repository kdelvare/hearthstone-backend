class Type < ActiveRecord::Base
  self.primary_key = 'hs_id'

  def create
    respond_with Type.create(type_params)
  end

  private

  def type_params
    params.require(:type).permit(:hs_id, :name)
  end
end
