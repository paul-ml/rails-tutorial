class Relationship < ApplicationRecord

	belongs_to :follower , class_name: "User"
	belongs_to :followed , class_name: "User"

	# if someone is following someone there is a relationship between 2 people.. if i am following x .. x and me are related.
	validates :follower_id , presence: true
	validates :followed_id , presence: true
end
