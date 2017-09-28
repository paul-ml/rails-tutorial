require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:michael)   # assuming that logged in michael
  end

  test "unsuccessful edit " do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "", email: "foo@imvalid" ,password:"abc",password_confirmation:"def"}}

    assert_template 'users/edit'
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = "Paul Joe"
    email = "abcd@gmail.com"
    patch user_path(@user) , params: {user: {name: name , email: email , password: "" , password_confirmation: ""}}
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email , @user.email 
  end
  test "successful edit with friendly forwarding" do
  
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    name  = "Foo Bar"
    email = "abcdefg@efghijk.com" 
    patch user_path(@user), params: { user: { name: name, email: email, password: "", password_confirmation: "" } }
    

    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end
end
