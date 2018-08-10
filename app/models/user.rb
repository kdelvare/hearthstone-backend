class User < ActiveRecord::Base
	def create
		respond_with User.create(user_params)
	end

	private

	def user_params
		params.require(:user).permit(:name)
	end
end
