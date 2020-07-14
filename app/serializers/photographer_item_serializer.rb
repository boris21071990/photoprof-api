class PhotographerItemSerializer < PhotographerSerializer
  attributes :city, :categories, :photos

  def city
    ActiveModelSerializers::SerializableResource.new(object.city, serializer: CitySerializer)
  end

  def categories
    ActiveModelSerializers::SerializableResource.new(object.categories, each_serializer: CategorySerializer)
  end

  def photos
    ActiveModelSerializers::SerializableResource.new(object.enabled_photos.take(5), each_serializer: PhotoSerializer)
  end
end
