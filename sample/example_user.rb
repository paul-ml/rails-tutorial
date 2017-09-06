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


	class Details

attr_accessor :fname, :lname

def initialize(attributes={})
@fname= attributes[:fname]
@lname=attributes[:lname]
end

def display
"#{@fname}  #{@lname} "
end

	end

