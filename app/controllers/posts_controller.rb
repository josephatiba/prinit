require_relative 'printful'


class PostsController < ApplicationController
  

  def index
    @posts = Post.all.order(created_at: :desc)
    @order_item = current_order.order_items.new
  end

  def show
    @post = Post.find(params[:id])
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
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
     if @post.destroy
       redirect_to root_path
     end
  end

  private

  def find_post
    @post = Post.where(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :price, :public, :active, :two_to_three, :two_to_three_l, :image, :tile, :user, :post_thumbnail, :profile_pic, :prof_pic)
  end

  def authorize
    if @post.user != current_user
      redirect_to @post
    end
  end
end
