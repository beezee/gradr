class UserMailer < ActionMailer::Base
  default from: "info@gradr.net"

  def login_email(user)
    @user = user
    mail(to: @user.email, subject: "Your login link for gradr.net")
  end
end
