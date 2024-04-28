require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "Requires a name" do 
    @user = User.new(name: "", email: "test@example.com", password: "password")
    assert_not @user.valid?

    @user.name = "The name"
    assert @user.valid?
  end

  test "Requires a valid email" do 
    @user = User.new(name: "The name", email: "", password: "password")
    assert_not @user.valid?

    @user.email = "invalid"
    assert_not @user.valid?

    @user.email = "test@example.com"
    assert @user.valid?
  end

  test "requires a unique email" do 
    @existing_user = User.create(name: "The name", email: "test@example.com", password: "password")

    assert @existing_user.persisted?

    @user = User.new(name: "Another name", email: "test@example.com", password: "password")

    assert_not @user.valid?
  end

  test "name and email are stripped of spaces before saving" do 
    @user = User.create(name: "The name ", email: "test@email.com  ")
    assert_equal "The name", @user.name 
    assert_equal "test@email.com", @user.email
  end

  test "email is downcased" do 
    @user = User.create(name: "The name ", email: "TEST@eMaIl.Com")
    assert_equal "test@email.com", @user.email
  end

  test "password length must be between 8 and ActiveRecord's maximum" do 
    @user = User.new(name: "The name", email: "test@email.com", password: "")

    assert_not @user.valid?

    @user.password = "password"
    assert @user.valid?

    max_length = ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED
    @user.password = 'a' * ( max_length + 1 )
    assert_not @user.valid?
  end
end
