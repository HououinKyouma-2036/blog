require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @post = posts(:one)
    @comment = comments(:one)
  end

  test "should create comment when logged in" do
    login_as(@user)
    assert_difference("Comment.count") do
      post post_comments_path(@post), params: {
        comment: {
          body: "Test comment",
          status: "public"
        }
      }
    end
    assert_redirected_to post_path(@post, anchor: "comment-#{Comment.last.id}")
  end

  test "should not create comment when not logged in" do
    assert_no_difference("Comment.count") do
      post post_comments_path(@post), params: {
        comment: {
          body: "Test comment",
          status: "public"
        }
      }
    end
    assert_redirected_to login_path
  end
end
