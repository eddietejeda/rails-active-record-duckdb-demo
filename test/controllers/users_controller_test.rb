require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    # Create test data manually since DuckDB fixtures may not work reliably
    @user = User.create!(
      name: "John Doe",
      email: "john@example.com",
      age: 30,
      active: true,
      bio: "A sample user for testing"
    )
  end

  teardown do
    # Clean up test data for isolation
    Post.destroy_all
    User.destroy_all
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post users_url, params: { user: { active: @user.active, age: @user.age, bio: @user.bio, email: @user.email, name: @user.name } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { active: @user.active, age: @user.age, bio: @user.bio, email: @user.email, name: @user.name } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference("User.count", -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
