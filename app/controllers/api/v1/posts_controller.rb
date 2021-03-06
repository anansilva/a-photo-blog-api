module Api
  module V1
    class PostsController < ApplicationController
      def index
        @posts = current_user.posts.with_attached_photo
        render json: @posts
      end

      def create
        post = Post.new(photo: post_params[:photo], user_id: current_user.id)
        if post.save
          render json: post
        else
          render json: post, status: :unprocessable_entity
        end
      end

      def destroy
        post = Post.find(params[:id])
        if post.destroy
          render json: post
        else
          render json: post, status: :unprocessable_entity
        end
      end

      private

      def post_params
        params.require(:post).permit(:photo)
      end
    end
  end
end
