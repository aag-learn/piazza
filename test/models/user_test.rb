require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'Requires a name' do
    @user = User.new(name: '', email: 'test@example.com', password: 'password')
    assert_not @user.valid?

    @user.name = 'The name'
    assert @user.valid?
  end

  test 'Requires a valid email' do
    @user = User.new(name: 'The name', email: '', password: 'password')
    assert_not @user.valid?

    @user.email = 'invalid'
    assert_not @user.valid?

    @user.email = 'test@example.com'
    assert @user.valid?
  end

  test 'requires a unique email' do
    @existing_user = User.create(name: 'The name', email: 'test@example.com', password: 'password')

    assert @existing_user.persisted?

    @user = User.new(name: 'Another name', email: 'test@example.com', password: 'password')

    assert_not @user.valid?
  end

  test 'name and email are stripped of spaces before saving' do
    @user = User.create(name: 'The name ', email: 'test@email.com  ')
    assert_equal 'The name', @user.name
    assert_equal 'test@email.com', @user.email
  end

  test 'email is downcased' do
    @user = User.create(name: 'The name ', email: 'TEST@eMaIl.Com')
    assert_equal 'test@email.com', @user.email
  end

  test 'can update the name only' do
    user = users(:jerry)
    user.name = 'The new name'

    assert user.valid?
    user.save
    assert_equal 'The new name', user.reload.name
  end

  test 'password_change context validates the password' do
    user = users(:jerry)
    user.password = 'wrong'
    user.password = 'wrong'
    assert_not user.valid?(:password_change)
  end

  test 'can update the user and the password using the context_change context' do
    user = users(:jerry)
    user.password = 'newpassword'
    user.password_confirmation = 'newpassword'
    user.name = 'The new name'
    assert user.valid?(:password_change)
    user.save context: :password_change
    assert_equal 'The new name', user.reload.name
    assert user.authenticate('newpassword')
  end

  test 'can update user without updating the password' do
    user = users(:jerry)
    user.name = 'The new name'
    assert user.valid?
  end
end
