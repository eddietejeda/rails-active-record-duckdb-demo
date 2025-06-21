require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    # Create test data manually since DuckDB fixtures may not work reliably
    @user = User.create!(
      name: "John Doe",
      email: "john@example.com",
      age: 30,
      active: true,
      bio: "A sample user for testing"
    )
    
    @post = Post.create!(
      user: @user,
      title: "First Test Post",
      content: "This is the content of the first test post.",
      status: "published",
      view_count: 100,
      rating: 4.5,
      published_at: 2.weeks.ago,
      category: "tutorial",
      featured: true
    )
  end

  teardown do
    # Clean up test data for isolation
    Post.destroy_all
    User.destroy_all
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should get new" do
    get new_post_url
    assert_response :success
  end

  test "should create post" do
    assert_difference("Post.count") do
      post posts_url, params: { post: { content: @post.content, published_at: @post.published_at, rating: @post.rating, status: @post.status, title: @post.title, user_id: @post.user_id, view_count: @post.view_count } }
    end

    assert_redirected_to post_url(Post.last)
  end

  test "should show post" do
    get post_url(@post)
    assert_response :success
  end

  test "should get edit" do
    get edit_post_url(@post)
    assert_response :success
  end

  test "should update post" do
    patch post_url(@post), params: { post: { content: @post.content, published_at: @post.published_at, rating: @post.rating, status: @post.status, title: @post.title, user_id: @post.user_id, view_count: @post.view_count } }
    assert_redirected_to post_url(@post)
  end

  test "should destroy post" do
    assert_difference("Post.count", -1) do
      delete post_url(@post)
    end

    assert_redirected_to posts_url
  end
end
