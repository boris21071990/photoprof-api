class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :category_id, :image_url, :small_image_url, :medium_image_url, :large_image_url,
             :likes_count, :views_count

  def image_url
    return unless object.image

    object.image.url(host: Rails.application.credentials.host)
  end

  def small_image_url
    return unless object.image

    object.image(:small).url(host: Rails.application.credentials.host)
  end

  def medium_image_url
    return unless object.image

    object.image(:medium).url(host: Rails.application.credentials.host)
  end

  def large_image_url
    return unless object.image

    object.image(:large).url(host: Rails.application.credentials.host)
  end
end
