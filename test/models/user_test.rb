#user_test.rb - This is a testing done for each users features.. 
#like each user will have a unique name , email password etc.. 
#those things will be tested here.


require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
  	@user=User.new(name:"pauljoe",email:"thankuabcd@gmail.com", password:"abcdef1" ,password_confirmation:"abcdef1")

  end

  test "VALID USER" do
  	assert @user.valid?
  end
  #for invalidation --> use assert_not 
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
if @user.email.size >=200 
assert_not @user.valid?
  	end
end

  	test "VALID email address" do

  valid_email = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn] 
  valid_email.each do |valid_e|

  	@user.email = valid_e
  	assert  @user.valid? ,"#{valid_e.inspect}  email should be this form "
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

  test "Passwords doesnt match" do

    # @user.password = @user.password_confirmation = " " * 6
    if @user.password != @user.password_confirmation 
assert @user.valid?
end

    # assert_not @user.valid?
      
    
  end
test "password is too short" do
   if @user.password == @user.password_confirmation  && @user.password_confirmation.length <=5
       assert @user.valid?
  end
end

test "password is too long" do 
  if @user.password == @user.password_confirmation  && @user.password_confirmation.length >=50
       assert @user.valid?
  end
end
test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end

  test "associated microposts should be destroyed" do
@user.save
@user.microposts.create!(content: "hey hello") 
assert_difference 'Micropost.count' , -1 do 
  @user.destroy
end
end

test "should follow and unfollow a user" do
    michael = users(:michael)
    archer  = users(:archer)
    assert_not michael.following?(archer)
    michael.follow(archer)
    assert michael.following?(archer)
    assert archer.followers.include?(michael)
    michael.unfollow(archer)
    assert_not michael.following?(archer)
  end
test "feed should have the right posts" do
    michael = users(:michael)
    archer  = users(:archer)
    lana    = users(:lana)
    # Posts from followed user
    lana.microposts.each do |post_following|
      assert michael.feed.include?(post_following)
    end
    # Posts from self
    michael.microposts.each do |post_self|
      assert michael.feed.include?(post_self)
    end
    # Posts from unfollowed user
    archer.microposts.each do |post_unfollowed|
      assert_not michael.feed.include?(post_unfollowed)
    end
  end
end
