class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_post, only: :show

  def index
    @posts = Post.all
    @categories = Category.all
    @elements = Element.all
  end

  def show
    @categories = Category.all
    @elements = Element.all
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content)
    end
end