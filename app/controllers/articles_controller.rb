class ArticlesController < ApplicationController
  
  def index
    @articles = Article.all
  end
  
  def new
    @article = current_user.articles.build()
  end
  
  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to articles_path, notice: '保存に成功しました'
    else
      flash.now[:error] = '保存に失敗しました'
      render :new
    end
  end
  
  def show
    @article = Article.find_by(id: params[:id])
  end
  
  
  private
  
  def article_params
    params.require(:article).permit(:content, images: [])
  end    
end