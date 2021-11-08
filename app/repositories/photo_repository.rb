class PhotoRepository
  def self.find_enabled_by_id!(id)
    Photo.find_by!(id: id, enabled: true)
  end
end
