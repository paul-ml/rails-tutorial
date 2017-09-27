require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base=" PJ dESIGNS"
  end

test "should get to root" do
  get root_path
  assert_response :success
end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title","Help |#{@base}"
  end

  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title","Home |#{@base}"
  end
test "should get about" do
    get about_path
    assert_response :success
    assert_select "title","About |#{@base}"
  end
test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title","Contact |#{@base}"
  end

end
