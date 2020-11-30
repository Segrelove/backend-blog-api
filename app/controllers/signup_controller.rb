class SignupController < ApplicationController
  def create
    author = Author.new(author_params)

    if author.save
      payload = { author_id: author.id }
      session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
      tokens = session.login

      response.set_cookie(JWTSessions.access_cookie, 
                          value: tokens[:access],
                          httponly: true,
                          secure: Rails.env.production? )

      render json: { csrf: tokens[:csrf] }
    else
      render json: { error: author.errors.full_messages.join(' ') }, status: :unprocessable_entity
    end
  end

  private
    
    def author_params
      params.permit(:first_name, :last_name, :password, :password_confirmation)
    end
end
