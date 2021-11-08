class PhotoCreator
  attr_reader :photographer, :photo_params

  def initialize(photographer, photo_params = {})
    @photographer = photographer
    @photo_params = photo_params
  end

  def call
    photo = Photo.new(photographer: photographer, image: photo_params[:image], category_id: 0)

    unless photo.valid?
      errors = photo.errors.full_messages.map { |message| { type: "validation", message: message } }

      return Result.failure(errors)
    end

    photo.save!

    photo.image_derivatives!

    Result.success(photo: photo)
  end
end
