require_relative 'printful'


class PostsController < ApplicationController
  

  def index
    @posts = Post.all.order(created_at: :desc)
    @post = Post.find(find_post)
    @order_item = current_order.order_items.new
  end

  def show
    @post = Post.find(find_post)
    @printful = Printful.new
    @order_item = current_order.order_items.new
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(find_post)
  end

  def update
    @post = Post.find(find_post)
    if @post.update_attributes(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  private

  def find_post
    @post = Post.where(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :price, :public, :active, :image, :two_to_three, :four_to_five, :three_to_four, :one_to_one)
  end

  def authorize
    if @post.user != current_user
      redirect_to @post
    end
  end
end
