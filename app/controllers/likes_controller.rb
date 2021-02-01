class LikesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :like_counts
  
  def show
    article = Article.find_by(id: params[:article_id])
    like_status = article.likes.find_by(user_id: current_user.id).present?
    render json: { hasLiked: like_status, likeCount: like_counts }
    
    
  end
  
  
  def create
    article = Article.find_by(id: params[:article_id])
    article.likes.create!(user_id: current_user.id)
    render json: { status: 'ok', likeCount: like_counts }
  end
  
  def destroy
    article = Article.find_by(id: params[:article_id])
    @like = article.likes.find_by(user_id: current_user.id)
    @like.destroy!
    render json: { status: 'ok', likeCount: like_counts }
  end
  
  
  def like_counts
    @article = Article.find(params[:article_id])
    @article.likes.count
  end
end