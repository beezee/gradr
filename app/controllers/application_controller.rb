class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found
  include SessionsHelper
  before_filter :authorize, :except => [:request_invite, :login]

  def default_url_options
    {:host => ENV['APP_URL']}
  end

  def authorize
    if !signed_in?
      redirect_to invite_request_url 
    end
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
