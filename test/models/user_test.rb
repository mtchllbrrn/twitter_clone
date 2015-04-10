require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'Example User', email: 'user@example.com',
                     password: 'foobar', password_confirmation: 'foobar')
  end
  
  test 'should be valid' do
    @user.valid?
  end
  
  test 'name should not be blank' do
    @user.name = '    '
    assert_not @user.valid?
  end
  
  test 'email should not be blank' do
    @user.email = '    '
    assert_not @user.valid?
  end
  
  test 'name should be within length range' do
    @user.name = 'a' * 51
    assert_not @user.valid?
    @user.name = 'aa'
    assert_not @user.valid?
  end
  
  test 'email should be within length range' do
    @user.email = 'a' * 244 + '@example.com'
    assert_not @user.valid?
    @user.email = 'a@'
    assert_not @user.valid?
  end
  
  test 'should accept valid emails' do
    valid_emails = %w[user@example.com USER@foo.example.com foo.bar@example.com
                      foo-bar+baz@example.qux.com foo_bar@example.com]
    valid_emails.each do |valid_email|
      @user.email = valid_email
      assert @user.valid?, "#{valid_email.inspect} should be valid"
    end
  end
  
  test 'should reject invalid emails' do
    invalid_emails = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_emails.each do |invalid_email|
      @user.email = invalid_email
      assert_not @user.valid?, "#{invalid_email.inspect} should be invalid"
    end
  end
  
  test 'email should be unique' do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test 'password should reach minimum requirement' do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end
  
  test 'email should save as downcase' do
    mixed_case_email = 'uSeR_fOo@eXaMPle.cOm'
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.email
  end
  
  test 'authenticated? should return false for a user with nil digest' do
    assert_not @user.authenticated?(:remember, '')
  end
  
  test 'associated microposts should be destroyed' do
    @user.save
    @user.microposts.create!(content: "Lorem ipsum")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end
end
