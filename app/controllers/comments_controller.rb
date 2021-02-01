class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  
  def index
    article = Article.find(params[:article_id])
    comments = article.comments
    render json: comments
  end
  
  
  def new
    article = Article.find(params[:article_id])
    @comment = article.comments.build
  end
  
  def create
    article = Article.find(params[:article_id])
    @comment = article.comments.build(comments_params)
    @comment.user_id = current_user.id
    @comment.save!
    
    render json: @comment
  end  
  
  
  private
  
  def comments_params
    params.require(:comment).permit(:content, :user_id )
  end
end