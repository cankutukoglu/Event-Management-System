require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post users_url, params: { user: { email_address: "test@example.com", password: "password123", password_confirmation: "password123", username: "testuser", user_type: "regular" } }
    end
    assert_redirected_to new_session_path
  end
end
