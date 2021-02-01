class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  
  def index
    @article = Article.find(params[:article_id])
    @comments = @article.comments
  end
  
  def new
    article = Article.find(params[:article_id])
    @comment = article.comments.build
  end
  
  def create
    article = Article.find(params[:article_id])
    @comment = article.comments.build(comments_params)
    @comment.user_id = current_user.id
    if @comment.save
      render json: @comment
    else
      render :new
    end    
  end  
  
  
  private
  
  def comments_params
    params.require(:comment).permit(:content, :user_id )
  end
end