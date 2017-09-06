class User
	attr_accessor :name,:email

	def initialize(attributes={})

	@name=attributes[:name]
	@email=attributes[:email]
	end

	def formatted_email
		"#{@name},#{@email}"
	end


end


	class Userr

		attr_accessor :name,:age

		def initialize(attributes={})
			@name=attributes[:name]
			@age=attributes[:age]
		end

		def display

			"#{@name}, #{@age}"
		end
end
