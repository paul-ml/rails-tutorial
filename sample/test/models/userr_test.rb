require 'test_helper'

class UserrTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@user=Userr.new(name:" ",email:"thanku@gmail.com")

  end

  test "VALID USER" do
  	assert @user.valid?
  end
  test "NOT VALID" do
@user.name ="  "
assert_not @user.valid?

  end
  test "name is too long" do 
  	@user.name ="a" * 51
  	assert_not @user.valid?
  end

  test "email is NOT valid" do
  	@user.email ="  " 
  	assert_not @user.valid?
  end

  test "email is too loong" do 
@user.email ="a"*244 + "@example.com"
assert_not @user.valid?
  	end


  	test "VALID email address" do

  valid_email = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn] 
  valid_email.each do |valid_e|

  	@user.email = valid_e
  	assert @user.valid? ,"#{valid_e.inspect} should be valid"
  	end
end

test "INVALID email address" do
invalid_email =%w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
invalid_email.each do |invalid_e|
@user.email = invalid_e

assert_not @user.valid? , "#{invalid_e.inspect} is INVALID"
end
end
test "email addresses should be UNIQUE" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

end
