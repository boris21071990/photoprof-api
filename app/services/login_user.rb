class LoginUser
  attr_reader :email, :password

  def initialize(email:, password:)
    @email = email
    @password = password
  end

  def call
    unless user_form.valid?
      errors = user_form.errors.full_messages.map { |message| { type: "validation", message: message } }

      return Result.failure(errors)
    end

    user = User.find_by(email: email)

    return Result.failure(type: "validation", message: "User not found") unless user

    return Result.failure(type: "validation", message: "Password is not valid") unless user.authenticate(password)

    Result.success(user: user)
  end

  private

  def user_form
    @user_form ||= UserForm.new(email: email, password: password)
  end
end
