class LikeController < ApplicationController
    def create
        @like = Like.new(
            user_id: @current_user.id,
            post_id: params[:id]
        )
        @like.save
        @likes = Like.where(post_id: params[:id]).count
        redirect_to("/posts/#{params[:id]}")
    end

    def destroy
        @post = Post.find_by(id: params[:id])
        @like = Like.find_by(
            user_id: @current_user.id,
            post_id: @post.id
        )
        @like.destroy
        @likes = Like.where(post_id: @post.id).count
        redirect_to("/posts/#{@post.id}")
    end
end
