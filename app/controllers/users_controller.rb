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
      redirect_to dashboard_url and return
    end
    @user = params[:user] ? User.new.invite(params[:user][:email]) : User.new
    respond_to do |f|
      f.html { render :layout => false }
    end
  end

  def dashboard
   @graders = current_user.graders.includes(:grader_scorecards).paginate(:page => params[:graders_page])
   @gradees = current_user.gradees.includes(grader_scorecards: :scores).where('grader_scorecards_users.grader_id = ?', current_user.id)
                    .paginate :page => params[:gradees_page]
  end
end
