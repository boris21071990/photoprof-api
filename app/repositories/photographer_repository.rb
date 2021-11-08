class PhotographerRepository
  def self.find_enabled_by_slug!(slug)
    Photographer.find_by!(enabled: true, slug: slug)
  end
end
