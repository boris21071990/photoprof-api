module UserAuthentication
  extend ActiveSupport::Concern

  include JWTSessions::RailsAuthorization

  included do
    serialization_scope nil

    rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized
  end

  def current_user
    @current_user ||= User.find(payload["user_id"])
  end

  private

  def not_authorized
    render json: { data: nil, errors: [{ type: "authorization", message: "Unauthorized user" }] }, status: 401
  end
end
