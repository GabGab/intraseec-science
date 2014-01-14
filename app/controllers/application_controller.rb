class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_p3p_headers
  before_filter :refresh_session

  def current_user
    @current_user ||= begin
      if session[:expires] && session[:expires] != 0 && session[:expires].to_i < Time.zone.now.to_i
        session[:uid] = nil
      elsif session[:uid]
        user = User.find_or_create_by_uid(session[:uid])
        user
      end
    end
  end

  def set_p3p_headers
    headers['P3P'] = 'policyref="http://' + request.host + '/w3c/p3p.xml", CP= "CAO PSA OUR"'
  end

  def refresh_session
    render("sessions/redirection") and return if session[:expires] && session[:expires] != 0 && session[:expires].to_i < Time.zone.now.to_i
  end

end
