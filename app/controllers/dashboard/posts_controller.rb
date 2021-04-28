class Dashboard::PostsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_post, only: %i[ show edit update destroy ]
  layout "dashboard/dashboard"

  def index
    @posts = Post.all
    @categories = Category.all
    @elements = Element.all
    @total_count = Post.count
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post
    else
      :new
    end
  end

  def update
    if @post.update(post_params)
     redirect_to @post
    else
      :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to :posts
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content)
    end
end
