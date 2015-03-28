require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @base_title = 'Twitteresque'
  end
  
  test 'should get new' do
    get :new
    assert_response :success
  end
  
  test 'titles should be correct' do
    get :new
    assert_select 'title', "Sign Up | #{@base_title}"
  end
end
