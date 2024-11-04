require "test_helper"

class CommentTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @post = posts(:one)
  end

  test "should not save comment without user" do
    comment = Comment.new(body: "Test comment", post: @post, status: "public")
    assert_not comment.save, "Saved the comment without a user"
  end

  test "should not save comment without body" do
    comment = Comment.new(user: @user, post: @post, status: "public")
    assert_not comment.save, "Saved the comment without a body"
  end

  test "should save valid comment" do
    comment = Comment.new(
      body: "Test comment",
      user: @user,
      post: @post,
      status: "public"
    )
    assert comment.save, "Could not save valid comment"
  end
end
