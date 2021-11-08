class PhotographerViewSerializer < PhotographerItemSerializer
  def photos
    ActiveModelSerializers::SerializableResource.new(object.enabled_photos, each_serializer: PhotoSerializer)
  end
end
