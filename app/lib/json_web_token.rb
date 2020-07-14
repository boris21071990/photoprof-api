class JsonWebToken
  DEFAULT_TOKEN_EXPIRATION = 1800
  JWT_ALGORITHM = "HS256"

  def self.encode(payload = {}, expiration = DEFAULT_TOKEN_EXPIRATION)
    payload[:exp] = expiration.seconds.from_now.to_i

    jwt_secret = Rails.application.credentials.jwt_secret

    JWT.encode(payload, jwt_secret, JWT_ALGORITHM)
  end

  def self.decode(token)
    jwt_secret = Rails.application.credentials.jwt_secret

    JWT.decode(token, jwt_secret, true, { algorithm: JWT_ALGORITHM }).first.with_indifferent_access.except(:exp)
  end
end
