class UsersController < ApplicationController
  def login
    @user = User.friendly.find params[:slug] 
    if !@user.check_link_hash params[:link_hash]
      return not_found
    end

  end

  def request_invite
    if !params[:user]
      return @user = User.new
    end
    @user = User.new.invite params[:user][:email]
  end
end
