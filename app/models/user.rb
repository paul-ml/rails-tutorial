require 'irb'
class User < ApplicationRecord

    attr_accessor :remember_token , :activation_token , :reset_token
    has_many :microposts , dependent: :destroy    # arranges for microposts to be destroyed when user is destroyed
    has_many :active_relationships , class_name: "Relationship",
              foreign_key: "follower_id" , dependent: :destroy     #foriegn key is follower_id as table contains only follower id and followed id
  
    has_many :passive_relationships , class_name: "Relationship" , 
              foreign_key: "followed_id" , dependent: :destroy
    has_many :following , through: :active_relationships,  source: :followed
    has_many :followers , through: :passive_relationships, source: :follower

    
	  before_save  :downcase_email
    before_create :create_activation_digest
	 # before_save { email.downcase! }

	 validates :name, presence: true, length: { maximum: 50 }

	 VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	 validates :email, presence: true,length: {maximum: 256} , format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }  
	 # ---uniqueness true   * uniqueness: true *is another option if case sensitive is not an important factor ---#
	 has_secure_password
	 validates :password, presence: true, length: { minimum: 6 }, allow_nil: true 



	# create a random string digest and save in encrypted format
    def self.digest(string)
       cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end


   # Generates 22 sized  string  --> eg: (oolHJMYjlb8ki5F4wDwjQg)
    def self.new_token
      SecureRandom.urlsafe_base64
    end

   #generated token is updated in dB and remember_token
    def remember
      self.remember_token = User.new_token
      update_attribute(:remember_digest, User.digest(remember_token))
    end

   #Checks whether (activation_digest, remember_token) or (reset_digest,reset_token) matches
    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end

   #Once clicked on logout button --> remember_digest stored in DB will be made nil 
  def forget
     update_attribute(:remember_digest, nil)
  end

  #find users whom user is following 
  def feed
    # Micropost.where("user_id = ?", id) --- this is for showing only current users feeds
    #Micropost.where("user_id IN (:following_ids) OR user_id = :user_id", following_ids: following_ids , user_id: id)  # for displaying  following feeds
    following_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
  end
    
    # means updating the activated col in db as 'activated'and time
    def activate
       #update_attribute(:activated,    true)
        #update_attribute(:activated_at, Time.zone.now)
        update_columns(activated: true, activated_at: Time.zone.now)
    end

  # calls an external service to send mail
    def send_activation_email
      UserMailer.account_activation(self).deliver_now
    end
  #Once the user submit email in login forgot page remember_digest will be made and saved in D
  def create_reset_digest
    self.reset_token = User.new_token
    self.reset_digest = User.digest(reset_token)
    self.save
  end
#password reset mail will be send with email and activation digest
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end


  def follow(other_user)
    following << other_user
  end
                                # follow other user -> add him to my following array   ...  unfollow other user -> pop him out from the array 
  def unfollow(other_user)
    following.delete(other_user)
  end
  #it checks in the following array of user whether the one which we are searching is included in array or not
  def following?(other_user)

    following.include?(other_user)
  end

    private 
  def downcase_email
        self.email = email.downcase
   end

      # Creates and assigns the activation token and digest.
  def create_activation_digest
        
     #self.activation_digest = User.digest(activation_token)
       self.activation_token  = User.new_token
     
       # self.update_attribute = {:activation_digest = activation_token}
       self.activation_digest = User.digest(activation_token)
      
   end
end
