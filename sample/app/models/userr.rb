class Userr < ApplicationRecord
	before_save { self.email = email.downcase }
	# before_save { email.downcase! }
	validates :name, presence: true, length: {maximum: 50}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true,length: {maximum:256} , format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }  
	# ---uniqueness true   * uniqueness: true *is another option if case sensitive is not an important factor ---#


	
end
