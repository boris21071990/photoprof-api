class User < ApplicationRecord
  has_secure_password

  ROLE_PHOTOGRAPHER = "photographer".freeze

  enum role: { ROLE_PHOTOGRAPHER => 0 }

  has_one :photographer
end
