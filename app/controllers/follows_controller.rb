class FollowsController < ApplicationController
  
  def show
    follow_status = current_user.follow?(params[:account_id])
    render json: { followStatus: follow_status }
  end
    
  def create
    current_user.follow!(params[:account_id])
    render json: { status: 'ok' }
  end
  
  def destroy
    current_user.unfollow!(params[:account_id])
    render json: { status: 'ok' }
  end
end