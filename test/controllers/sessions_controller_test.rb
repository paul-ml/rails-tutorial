require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base="Ruby on Rails Tutorial"
  end

  test "should get new" do
    get login_path
    assert_response :success
  end



test "should get login" do
    get login_path
    assert_response :success
    assert_select "title","Login|#{@base}"
  end
end
