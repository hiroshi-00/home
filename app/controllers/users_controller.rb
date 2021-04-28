class UsersController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!
  
  def edit
  end

  def update
    @user.update_without_password(user_params)
    redirect_to mypage_users_url
  end

  def mypage
  end
  
  def favorite
    @favorites = @user.likes
  end

  
  private
    def set_user
      @user = current_user
    end
    
    def user_params
      params.permit(:nickname, :game_id, :gender, :image, :password, :password_confirmation)
    end
end
