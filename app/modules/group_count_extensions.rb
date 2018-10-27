# Fix for https://github.com/cerebris/jsonapi-resources/issues/984

module GroupCountExtensions
	def count(*args)
		scope = except(:select).select("1")
		scope_sql = if scope.klass.connection.respond_to?(:unprepared_statement)
			scope.klass.connection.unprepared_statement { scope.to_sql }
		else
			scope.to_sql
		end
		query = "SELECT count(*) AS count_all FROM (#{scope_sql}) x"
		#ActiveRecord::Base.connection.execute(query).first.try(:[], "count_all").to_i
		ActiveRecord::Base.connection.execute(query).first[0]
	end
end
