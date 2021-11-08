class UserSerializer < ActiveModel::Serializer
  attributes :email, :role, :image_url

  def image_url
    return unless object.photographer.image(:small)

    object.photographer.image(:small).url(host: Rails.application.credentials.host)
  end

  def role
    object.role
  end
end
