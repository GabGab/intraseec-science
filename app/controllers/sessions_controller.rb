class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]
  skip_before_filter :refresh_session
  # around_filter :rescue_fb_errors, :only => [:create]

  def new
    respond_to do |format|
      format.html { render :new }
    end
  end

  # SAMPLE RETURNS FROM FACEBOOK AFTER PARSING SIGNED REQUEST
  # App not accepted
  # {
  #     "algorithm" => "HMAC-SHA256",
  #     "issued_at" => 1390354986,
  #          "page" => {
  #            "id" => "293080470785802",
  #         "liked" => true,
  #         "admin" => true
  #     },
  #          "user" => {
  #         "country" => "fr",
  #          "locale" => "en_US",
  #             "age" => {
  #             "min" => 21
  #         }
  #     }
  # }
  # App accepted
  # {
  #       "algorithm" => "HMAC-SHA256",
  #         "expires" => 1390359600,
  #       "issued_at" => 1390355010,
  #     "oauth_token" => "CAAF074KDK9EBAGd7g3ZCCbMkByMx0JcpqCmWXBm5t8VR37x71UZCcExPW3RMPTA6vwCRFGq2xLOkOxCXGiGDfXRlc4BpqEcOtjOZBNwq2p4AgaKtMoI8oeqzHIglfTd1UAl4lHsRy3xc17dxf8nywD4qFc091j0nyNyg3QzE4gvOuqsrIuOk6wylidskZAGhV2eqPLU08gZDZD",
  #            "page" => {
  #            "id" => "293080470785802",
  #         "liked" => true,
  #         "admin" => true
  #     },
  #            "user" => {
  #         "country" => "fr",
  #          "locale" => "en_US",
  #             "age" => {
  #             "min" => 21
  #         }
  #     },
  #         "user_id" => "607643245"
  # }
  def create
    if params["signed_request"]
      oauth = Koala::Facebook::OAuth.new(create_session_url)
      response = oauth.parse_signed_request(params["signed_request"])
      if !response["page"]["liked"]
        render "users/fan_gate"
      else
        raise response.inspect
        if response['oauth_token']
          session[:expires_in] = response['expires'] == 0 ? 0 : Time.now.to_i + response['expires'].to_i
          session[:uid] = response['user_id']

          user = User.find_by(:uid => response['user_id']) || User.new(:uid => response['user_id'])
          user.access_token = response['oauth_token'] if response['oauth_token']
          user.expire = response['expires'] if response['expires']
          user.save(:validate => false)
          @user = @current_user = user

          redirect_to @user.masters.present? ? user_url(@current_user) : edit_user_url(@current_user)
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