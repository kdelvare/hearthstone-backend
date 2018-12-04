class Year < ActiveRecord::Base
	has_many :cardsets

	def create
		respond_with Year.create(year_params)
	end

	private

	def year_params
		params.require(:year).permit(:name, :name_fr, :standard)
	end
end
