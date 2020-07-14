module UserAuthentication
  extend ActiveSupport::Concern

  included do
    attr_reader :current_user
  end

  def authenticate_user
    result = AuthenticateUser.new(request.headers).call

    if result.success?
      @current_user = result.data[:user]
    else
      render_errors result.errors, status: 401
    end
  end
end
