class AccountsController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    if @user.id === current_user.id
      redirect_to profile_path
    end
  end
end