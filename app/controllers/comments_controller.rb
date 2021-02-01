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
    comment_reply
    
    render json: @comment
  end  
  
  def comment_reply
    users = User.all
    users.each do |user|
      @to_name = user.account
      @from_name = @comment.user.account
      if @comment.content.include?("@#{@to_name}")
        @content = @comment.content.gsub(/\@#{@to_name}/,"#{@to_name}")
        MentionMailer.mention_to(user, @from_name, @content).deliver_now
        @comment.save!
      else
        @comment.save!
      end
    end
  end

  
  private
  
  def comments_params
    params.require(:comment).permit(:content, :user_id )
  end
end