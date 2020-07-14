class PhotographerFetcher
  def self.call(id)
    Photographer.find_by!(id: id, enabled: true)
  end
end
