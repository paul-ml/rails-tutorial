class Micropost < ApplicationRecord
belongs_to :user

 validates :contents, length: { maximum: 140 },presence: true
  
end
