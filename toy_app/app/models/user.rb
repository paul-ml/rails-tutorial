class User < ApplicationRecord
	has_many :microposts
validates :name,presence: true   
validates :email,presence: true  # Replace FILL_IN with the right code.
   # Replace FILL_IN with the right code.
end
