require 'test_helper'

class ChildPostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @child_post = child_posts(:one)
  end

  test "should get index" do
    get child_posts_url
    assert_response :success
  end

  test "should get new" do
    get new_child_post_url
    assert_response :success
  end

  test "should create child_post" do
    assert_difference('ChildPost.count') do
      post child_posts_url, params: { child_post: { body: @child_post.body, picture: @child_post.picture, root_post_id: @child_post.root_post_id } }
    end

    assert_redirected_to child_post_url(ChildPost.last)
  end

  test "should show child_post" do
    get child_post_url(@child_post)
    assert_response :success
  end

  test "should get edit" do
    get edit_child_post_url(@child_post)
    assert_response :success
  end

  test "should update child_post" do
    patch child_post_url(@child_post), params: { child_post: { body: @child_post.body, picture: @child_post.picture, root_post_id: @child_post.root_post_id } }
    assert_redirected_to child_post_url(@child_post)
  end

  test "should destroy child_post" do
    assert_difference('ChildPost.count', -1) do
      delete child_post_url(@child_post)
    end

    assert_redirected_to child_posts_url
  end
end
