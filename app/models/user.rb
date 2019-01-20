class User < ActiveRecord::Base
	has_secure_password
	has_many :collections, dependent: :destroy
	has_many :cards, through: :collections

	def create
		respond_with User.create(user_params)
	end

	private

	def user_params
		params.require(:user).permit(:name, :password)
	end
end
