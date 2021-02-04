class TimelinesController < ApplicationController
  before_action :authenticate_user!
  
  def show
    followings_ids = current_user.followings.pluck(:id)
    @articles = Article.where(user_id: followings_ids) #配列を渡すことで、or検索に
  end
end