module SessionsHelper

  def sign_in(user)
    session_token = user.random_string
    cookies.signed.permanent[:gridr] = session_token
    user.update_attribute :session_token, user.encrypt(session_token)
    self.current_user = user
  end

  def sign_out(user)
    user.update_attribute :session_token,
      user.encrypt(user.random_string)
    cookies.delete :gridr
    self.current_user = nil
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_session_token(
                                    User.new.encrypt(cookies.signed[:gridr]))
  end
end
