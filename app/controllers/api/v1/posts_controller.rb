module Api
  module V1
    class PostsController < ApplicationController

      def index
        posts = Post.all.with_attached_photo
        render json: posts
      end

      def create
        post = Post.new(photo: post_params[:photo])
        if post.save
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
