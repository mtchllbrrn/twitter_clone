require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  test 'on invalid sign in, flash should only show on one page' do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: 'foo@bar.com', password: 'foobar' }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert_template 'static_pages/home'
    assert flash.empty?, 'Flash persisted after invalid sign-in'
  end
end
