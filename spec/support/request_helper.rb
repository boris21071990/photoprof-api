module RequestHelper
  def json
    JSON.parse(response.body, symbolize_names: true)
  end

  def with_authorization_headers(user)
    tokens = JWTSessions::Session.new(payload: { user_id: user.id }).login

    request.headers["Authorization"] = "Bearer #{tokens[:access]}"
  end

  def with_refresh_token(user)
    payload_data = { user_id: user.id }

    tokens = JWTSessions::Session.new(payload: payload_data, refresh_payload: payload_data).login

    cookies[JWTSessions.refresh_cookie] = tokens[:refresh]

    request.headers[JWTSessions.csrf_header] = tokens[:csrf]
  end
end

RSpec.configure do |config|
  config.include RequestHelper
end
