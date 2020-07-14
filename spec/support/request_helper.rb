module RequestHelper
  def json
    JSON.parse(response.body, symbolize_names: true)
  end

  def with_authorization_headers(user)
    token = JsonWebToken.encode(user_id: user.id)

    request.headers["Authorization"] = "Bearer #{token}"
  end
end

RSpec.configure do |config|
  config.include RequestHelper
end
