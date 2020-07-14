class PhotographerImageUpdater
  attr_reader :photographer, :image

  def initialize(photographer, image)
    @photographer = photographer
    @image = image
  end

  def call
    photographer.image = image

    unless photographer.valid?
      errors = photographer.errors.full_messages.map { |message| { type: "validation", message: message } }

      return Result.failure(errors)
    end

    photographer.save!

    Result.success(image_url: photographer.reload.image(:small).url(host: Rails.application.credentials.host))
  end
end
