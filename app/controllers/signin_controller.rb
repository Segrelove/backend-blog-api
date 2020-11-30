class SigninController < ApplicationController
  before_action :authorize_access_request!, only: [:destroy]

  # For Login
  def create
    author = Author.find_by(email: params[:email])
    
    if author.authenticate(params[:password])
      payload = { author_id: author.id }
      session = JWTSession::Session.new(payload: payload, refresh_by_access_allowed: true)
      tokens = session.login
      response.set_cookie(JWTSessions.access_cookie,
                          value: tokens[:access],
                          httponly: true,
                          secure: Rails.env.production? )
      render json: { csrf: tokens[:csrf] }
    else
      not_authorized
    end
    
  end

  # For Logout
  def destroy
    session = JWTSessions::Session.new(payload: payload)
    session.flush_by_access_payload
    render json: :ok
  end

  private
    
    def not_found
      render json: { error: "Cannot find email/password combination" }, status: :not_found
    end
    

end
