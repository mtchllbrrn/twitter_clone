require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  def setup
    @base_title = "Twitteresque"
  end
  
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
  
  test "should get contact" do
    get :contact
    assert_response :success
  end
  
  test "titles should be correct" do
    get :home
    assert_select "title", "#{@base_title}"
    get :about
    assert_select "title", "About | #{@base_title}"
    get :help
    assert_select "title", "Help | #{@base_title}"
    get :contact
    assert_select "title", "Contact | #{@base_title}"
  end

end
