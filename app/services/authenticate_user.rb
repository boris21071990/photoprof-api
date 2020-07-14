class AuthenticateUser
  attr_reader :headers

  def initialize(headers)
    @headers = headers
  end

  def call
    payload = JsonWebToken.decode(token)

    user = User.find(payload["user_id"])

    Result.success(user: user)
  rescue JWT::DecodeError, ActiveRecord::RecordNotFound
    Result.failure(type: "authorization", message: "Unauthorized user")
  end

  private

  def token
    authorization_header = headers["Authorization"]

    return unless authorization_header

    authorization_header.split(" ").last
  end
end
