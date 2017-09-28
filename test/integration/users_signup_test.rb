require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

def setup
  user=users(:michael)
ActionMailer::Base.deliveries.clear

end

test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do    # same as assert_equal before_count , after_count
      post users_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    #if wrong  field values redirect to same page - thats why assert_template
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end



test "valid signup information with account activation" do
    get signup_path
    assert_difference 'User.count', 1 do    #incremenets the count by 1
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
follow_redirect!
  #follow_redirect!
#assert_template 'users/show'
#assert is_logged_in?
  
  end



end
