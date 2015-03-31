require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test 'invalid signup should not add to db' do
    get signup_path
    assert_no_difference User.count do
      post users_path user: { name: "",
                              email: "bogus@example",
                              password: "bogus",
                              password_confirmation: "morebogus" }
      assert_template 'users/new'
    end
  end
end
