class UserForm
  include ActiveModel::Model

  attr_accessor :email, :password

  EMAIL_FORMAT = /.+@.+\..+/

  validates :email, presence: true, format: { with: EMAIL_FORMAT }
  validates :password, presence: true

  validate :uniqueness_of_email, on: :create

  private

  def uniqueness_of_email
    errors.add(:email, "is taken") if User.exists?(email: email)
  end
end
