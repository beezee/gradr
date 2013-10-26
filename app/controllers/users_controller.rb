class UsersController < ApplicationController
  def login
    @user = User.friendly.find params[:slug] 
    if !@user.check_link_hash params[:link_hash]
      return not_found
    end
    self.sign_in @user
    redirect_to dashboard_url
  end

  def logout
    self.sign_out self.current_user
    redirect_to '/'
  end

  def request_invite
    if signed_in?
      redirect_to dashboard_url
    end
    if !params[:user]
      return @user = User.new
    end
    @user = User.new.invite params[:user][:email]
  end

  def dashboard
    respond_to do |f|
      f.html { render :layout => 'dashboard' }
    end
  end
end
