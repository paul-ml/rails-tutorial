require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end



  def setup
  @user = users(:michael)
  end
test "login with valid information followed by logout" do
    get login_path

    post login_path, params: { session: { email:    @user.email, password: 'password' } }

    assert is_logged_in?    # checks whether   user.id exists or not --> !session[:user.id]=nil?  --> if exists .. 

    

    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    #when user clicks on logout button 
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0

  end

  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not_empty cookies['remember_token']
  end

  test "login without remembering" do
    # Log in to set the cookie.
    log_in_as(@user, remember_me: '1')
    # Log in again and verify that the cookie is deleted.
    log_in_as(@user, remember_me: '0')
    assert_empty cookies['remember_token']
  end

  test "unsuccessful edit with friendly forwarding " do
    get edit_user_path(@user)
    log_in_as @user
    assert_redirected_to edit_user_path(@user)
    name ="Foo Bar"
    email ="abcd@efgh.com"
    pass = ""
    pass1 = ""
     patch user_path(@user), params: { user: { name:  name,
                                                  email: email,
                                                  password: pass,
                                                  password_confirmation: pass1 } }

    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
   assert_equal email, @user.email



  end

end
