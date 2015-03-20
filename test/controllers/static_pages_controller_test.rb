require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get help" do
    get :help
    assert_response :success
  end
  
  test "should get about" do
    get :about
    assert_response :success
  end
  
  test "titles should be correct" do
    get :home
    assert_select "title", "Home | Twitter Clone"
    get :about
    assert_select "title", "About | Twitter Clone"
    get :help
    assert_select "title", "Help | Twitter Clone"
  end

end
