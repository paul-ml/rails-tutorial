require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
	include ApplicationHelper


	def setup
@user =users(:michael)
	end

  # test "the truth" do
  #   assert true
  # end

test "profile display" do

get user_path(@user)
    assert_template 'users/show'
    #assert_select 'title', full_title()
    assert_select 'h1', text: @user.name
    assert_select 'h1>img.gravatar'
    assert_match @user.microposts.count.to_s, response.body   # response.boy contains full html source of the page 
    assert_select 'div.pagination'
    @user.microposts.paginate(page: 1).each do |micropost|
      assert_match micropost.content, response.body
    end
  
end

end
