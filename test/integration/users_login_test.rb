require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end
  
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
  
  test 'login with valid information' do
    get login_path
    post login_path, session: { email: @user.email, password: 'password' }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', user_path(@user)
    assert_select 'a[href=?]', logout_path
  end
end
