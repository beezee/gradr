class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found

  def default_url_options
    {:host => 'gradr.net'}
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
