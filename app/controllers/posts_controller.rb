class PostsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user,{only: [:edit, :update, :destroy]}
  def index
    #@posts = ["今日からProgateでRailsの勉強するよー！","投稿一覧ページ作成中！"]
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id:params[:id])
    @like = Like.find_by(user_id: @current_user.id, post_id: @post.id)
    @likes = Like.where(post_id: @post.id).count
  end

  def new
     @post = Post.new
  end

  def create
    @post=Post.new(
      content: params[:content],
      user_id: @current_user.id
    )
    if @post.save
      flash[:notice] = "投稿を作成しました"
      redirect_to("/posts/index")
    else
      render("/posts/new")
    end
  end

  def edit
      @post = Post.find_by(id:params[:id])
  end


  def update
  
    @post=Post.find_by(id:params[:id])
    @post.content=params[:content]
    if @post.save
      flash[:notice] = "投稿を変更しました"
      redirect_to("/posts/index")
    else
      flash[:notice] = @post.errors.full_messages[0]
      render("edit")
    end
  end

  def destroy
    @post = Post.find_by(id:params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to("/posts/index")
  end
  
  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end
end
