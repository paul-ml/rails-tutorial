require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end


	def setup
	  @user = users(:michael)
      @micropost = @user.microposts.build(content: "hey hello")    # once  we define associations properly @micropost will have corresponding user_id.
	  #@micropost = Micropost.new(content: "Lorem ipsum" , user_id: @user.id)
	end

	test "should be valid" do 
	  assert @micropost.valid?
	end

	test "user id should be present" do 
		@micropost.user_id = nil
		assert_not @micropost.valid?
	end

	test "content should be present" do 
		@micropost.content = "   "
		assert_not  @micropost.valid?
	end

	 test "content is too long" do 
		@micropost.content = "a" * 141
		assert_not @micropost.valid?
     end


 	test "newly created should be displayed first" do 
		assert_equal microposts(:most_recent) , Micropost.first
 	end

end
