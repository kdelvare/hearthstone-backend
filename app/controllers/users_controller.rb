class UsersController < JSONAPI::ResourceController
	before_action :doorkeeper_authorize!, only: [:me]

	def me
		render json: {
			data: {
				id: current_resource_owner.id,
				type: 'user',
				name: current_resource_owner.name
			}
		}
	end

	private

	# Find the user that owns the access token
	def current_resource_owner
		User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
	end
end
