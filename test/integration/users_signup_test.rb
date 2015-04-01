require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test 'invalid signup should not add to db' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path user: { name: "",
                              email: "bogus@example",
                              password: "bogus",
                              password_confirmation: "morebogus" }
      assert_template 'users/new'
    end
  end
  
  test 'valid signup should add user to db' do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { name: "Test User",
                                            email: "test@example.com",
                                            password: "foobar",
                                            password_confirmation: "foobar" }
    end
    assert_template 'users/show'
    assert is_logged_in?
  end
end
