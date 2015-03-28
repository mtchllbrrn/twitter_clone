require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'Example User', email: 'user@example.com')
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
  
end
