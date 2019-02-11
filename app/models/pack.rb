class Pack < ActiveRecord::Base
	belongs_to :user
	belongs_to :cardset

	def create
		respond_with Pack.create(pack_params)
	end

	private

	def pack_params
		params.require(:user_id, :cardset_id).permit(:number)
	end
end
