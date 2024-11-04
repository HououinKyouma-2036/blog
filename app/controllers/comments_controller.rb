class CommentsController < ApplicationController
    before_action :require_login

    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.build(comment_params)
        @comment.user = current_user

        if @comment.save
          redirect_to post_path(@post, anchor: "comment-#{@comment.id}")
        else
          redirect_to post_path(@post), alert: "Comment could not be created: #{@comment.errors.full_messages.join(', ')}"
        end
    end

    def destroy
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        @comment.destroy
        redirect_to post_path(@post), status: :see_other
    end

    private
        def comment_params
          params.require(:comment).permit(:body, :status)
        end
end
