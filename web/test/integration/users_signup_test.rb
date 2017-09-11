require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end


  test"Invalid SignUp Information" do


get signup_path
assert_no_difference 'User.count' do
	post users_path, params: {user: {name: "",email:"abcd@invalid",password: "abcd", password_confirmation: "efgh"}}
end
assert_template 'users/new'
 assert_select 'div#<CSS id for error explanation>'
    assert_select 'div.<CSS class for field with error>'
end




test "valid SignUp" do
get signup_path

assert_difference 'User.count' ,1 do
	 post users_path, params: {user: {name:"abcdefgh",email:"abcdefghj@gmail.com",password:"abcdefghtjk",password_confirmation:"abcdefghtjk"}}

end
follow_redirect!
assert_template 'users/show'

end


end
