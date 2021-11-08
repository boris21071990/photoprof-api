class RegisterUser
  attr_reader :email, :password, :first_name, :last_name, :city_id

  def initialize(email:, password:, first_name:, last_name:, city_id:)
    @email = email
    @password = password
    @first_name = first_name
    @last_name = last_name
    @city_id = city_id
  end

  def call
    unless user_form.valid?(:create)
      errors = user_form.errors.full_messages.map { |message| { type: "validation", message: message } }

      return Result.failure(errors)
    end

    unless photographer_form.valid?
      errors = photographer_form.errors.full_messages.map { |message| { type: "validation", message: message } }

      return Result.failure(errors)
    end

    photographer = create_photographer!

    Result.success(user: photographer.user)
  rescue ActiveRecord::RecordInvalid
    Result.failure(type: "validation", message: "Failed to create new user")
  end

  private

  def create_photographer!
    ActiveRecord::Base.transaction do
      user = User.create!(email: email, password: password, role: User::ROLE_PHOTOGRAPHER)

      Photographer.create!(user: user, first_name: first_name, last_name: last_name, city_id: city_id)
    end
  end

  def user_form
    @user_form ||= UserForm.new(email: email, password: password)
  end

  def photographer_form
    @photographer_form ||= PhotographerForm.new(first_name: first_name, last_name: last_name, city_id: city_id)
  end
end
