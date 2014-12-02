class PostsController < ApplicationController
  before_action :find_post, :only => [:show, :update, :destroy]

  def index
    render :json => Post.all
  end

  def show
    render :json => @post
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      render :json => post, :status => 200
    else
      render_errors
    end
  end

  def update
    if @post.update(post_params)
      render :json => @post, :status => 200
    else
      render_errors
    end
  end

  def destroy
    if @post.destory
      render :json => { success: true }, :status => 200
    else
      render_errors
    end
  end

  private

  def render_errors
    render :json => { errors: @post.errors.full_messages }, :status => 422
  end

  def find_post
    @post = Post.find_by(id: params[:id])

    render :json => @post, :status => 422 if @post.nil?
  end

  def post_params
    params.require(:posts).permit!
  end
end