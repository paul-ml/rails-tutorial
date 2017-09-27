require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base=" PJ dESIGNS"
  end

  test "should get new" do
    get login_path
    assert_response :success
  end



test "should get login" do
    get login_path
    assert_response :success
    assert_select "title","Login |#{@base}"
  end
end
