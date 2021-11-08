class PhotographerSerializer < ActiveModel::Serializer
  attributes :id, :city_id, :slug, :first_name, :last_name, :image_url, :description

  def image_url
    return unless object.image

    object.image(:small).url(host: Rails.application.credentials.host)
  end
end
