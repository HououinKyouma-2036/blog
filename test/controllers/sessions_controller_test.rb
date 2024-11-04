require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get login form" do
    get login_path
    assert_response :success
  end

  test "should create session with valid username" do
    post login_path, params: { username: "test_user" }
    assert_redirected_to root_path
    assert_equal "Logged in successfully!", flash[:notice]
  end

  test "should handle invalid login" do
    post login_path, params: { username: "" }
    assert_response :unprocessable_entity
    assert_equal "Invalid username", flash[:alert]
  end

  test "should destroy session" do
    # First login
    user = users(:one)
    login_as(user)

    # Then logout
    delete logout_path
    assert_redirected_to root_path
    assert_equal "Logged out successfully!", flash[:notice]
    assert_nil session[:user_id]
  end
end
