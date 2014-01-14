class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]
  skip_before_filter :refresh_session
  # around_filter :rescue_fb_errors, :only => [:create]

  def new
    respond_to do |format|
      format.html { render :new }
    end
  end

  def create
    if params["signed_request"]
      oauth = Koala::Facebook::OAuth.new(create_session_url)
      response = oauth.parse_signed_request(params["signed_request"])
      if !response["page"]["liked"]
        render "users/fan_gate"
      else
        if response['code']
          access_token_info = Koala::Facebook::OAuth.new.get_access_token_info(response['code'])

          if access_token_info['access_token']
            session[:expires_in] = access_token_info['expires'] == 0 ? 0 : Time.now.to_i + access_token_info['expires'].to_i
            session[:uid] = response['user_id']

            user = User.find_or_create_by(:uid => response['user_id'])
            user.token = access_token_info['access_token'] if access_token_info['access_token']
            user.expires = access_token_info['expires'] if access_token_info['expires']
            user.save
            @user = @current_user = user

            redirect_to @user.master.present? ? edit_user_url(@current_user) : user_url(@current_user)
          else
            # @url = oauth.url_for_oauth_code(:permissions => "")
            session[:uid] = nil
            redirect_to new_user_url
          end
        else
          session[:uid] = nil
          redirect_to new_user_url
        end
      end
    else
      session[:uid] = nil
      redirect_to new_user_url
    end
  end
  
end