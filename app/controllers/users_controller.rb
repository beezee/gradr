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
   @graders = current_user.graders.paginate(:page => params[:graders_page]).uniq
   @gradees = current_user.gradees.paginate(:page => params[:gradees_page]).uniq
  end

  def stats
    @grader = User.friendly.find params[:grader_slug]
    @gradee = User.friendly.find params[:gradee_slug]
    if current_user.id != @grader.id and current_user.id != @gradee.id
      return not_found
    end
    @title = current_user.id == @grader.id ? "Stats for gradee #{@gradee.email}" : "Stats from grader #{@grader.email}"
    @scorecards = Scorecard.where('updated_at > ? and grader_id = ? and gradee_id = ?', 2.months.ago, @grader.id, @gradee.id).order('updated_at ASC')
                            .preload(:scores)
    @scorecards_data = {}
    @scorecards.each do |s|
      @scorecards_data[s.id] = {}
      @scorecards_data[s.id]['url'] = s.url
      @scorecards_data[s.id]['date'] = s.updated_at
      @scorecards_data[s.id]['scores'] = {}
      @grader.criteria.each {|c| @scorecards_data[s.id]['scores'][c.name] = c.score_for_scorecard(s).score}
    end
    puts @scorecards_data
    puts @scorecards_data.to_json
  end
end
