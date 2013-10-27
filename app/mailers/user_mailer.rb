class UserMailer < ActionMailer::Base
  default from: "info@gradr.net"

  def login_request(params)
    @user = params[:user]
    params[:subject] = "Your login link for gradr.net"
  end

  def added_to_scorecard(params)
    @user = params[:user]
    @grader = params[:grader]
    params[:subject] = "#{@grader.email} has added a scorecard for you at gradr.net"
  end

  def invite(params)
    if (!defined?(params[:type])|| !UserMailer.respond_to?(params[:type]))
      params[:type] = 'login_request'
    end
    self.send params[:type], params
    mail(to: @user.email, subject: params[:subject]) do |f|
      f.html { render params[:type] }
    end
  end
end
