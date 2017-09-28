require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

	def setup
@user= users(:michael)
@other_user = users(:archer)
	end
  test "should get new" do
    get users_new_url
    assert_response :success
  end

  test "should redirect to index  when not logged_in " do 
    get users_path
    assert_redirected_to login_url
  end
test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end
test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  test "should redirect following when not logged in" do
    get following_user_path(@user)
    assert_redirected_to login_url
  end

  test "should redirect followers when not logged in" do
    get followers_user_path(@user)
    assert_redirected_to login_url
  end

  test "should redirect update when log_in_as another user" do
log_in_as(@other_user)
patch user_path(@user) , params: {user: {name: @user.name , email: @user.email}}
assert flash.empty?
assert_redirected_to root_path 

  end

  test "should redirect edit when log_in_as another user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_path
  end
end
