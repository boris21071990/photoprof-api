JWTSessions.encryption_key = Rails.application.credentials.jwt_secret

JWTSessions.token_store = Rails.env.test? ? :memory : :redis
