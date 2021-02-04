class TimelinesController < ApplicationController
  before_action :authenticate_user!
  
  def show
    followings_ids = current_user.followings.pluck(:id)
    @articles = Article.where(user_id: followings_ids).order(created_at: 'DESC') #配列を渡すことで、or検索に
  end
  
  
  def add_me
    
  end
end