class PhotoItemSerializer < PhotoSerializer
  attributes :photographer

  def photographer
    ActiveModelSerializers::SerializableResource.new(object.photographer, serializer: PhotographerSerializer)
  end
end
