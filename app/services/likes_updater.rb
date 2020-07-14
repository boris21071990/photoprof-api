class LikesUpdater
  attr_reader :photographer, :photo

  def initialize(photographer, photo)
    @photographer = photographer
    @photo = photo
  end

  def like
    photo.likes.find_or_create_by(photographer: photographer)

    likes_result(true)
  end

  def unlike
    photo.likes.where(photographer: photographer).destroy_all

    likes_result(false)
  end

  private

  def likes_result(is_liked)
    Result.success(is_liked: is_liked, likes_count: photo.likes.size)
  end
end
