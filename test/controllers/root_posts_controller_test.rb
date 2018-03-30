require 'test_helper'

class RootPostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @root_post = root_posts(:one)
  end

  test "should get index" do
    get root_posts_url
    assert_response :success
  end

  test "should get new" do
    get new_root_post_url
    assert_response :success
  end

  test "should create root_post" do
    assert_difference('RootPost.count') do
      post root_posts_url, params: { root_post: { body: @root_post.body, picture: @root_post.picture, subject: @root_post.subject } }
    end

    assert_redirected_to root_post_url(RootPost.last)
  end

  test "should show root_post" do
    get root_post_url(@root_post)
    assert_response :success
  end

  test "should get edit" do
    get edit_root_post_url(@root_post)
    assert_response :success
  end

  test "should update root_post" do
    patch root_post_url(@root_post), params: { root_post: { body: @root_post.body, picture: @root_post.picture, subject: @root_post.subject } }
    assert_redirected_to root_post_url(@root_post)
  end

  test "should destroy root_post" do
    assert_difference('RootPost.count', -1) do
      delete root_post_url(@root_post)
    end

    assert_redirected_to root_posts_url
  end
end
