
	class User

		attr_accessor :name,:age

		def initialize(attributes={})
			@name=attributes[:name]
			@age=attributes[:age]
		end

		def display

			"#{@name}, #{@age}"
		end
end
