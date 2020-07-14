class PhotoFetcher
  def self.call(id)
    Photo.find_by!(id: id, enabled: true)
  end
end
