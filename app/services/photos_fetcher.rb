class PhotosFetcher
  def self.call(page = 1, filter = {})
    relation = Photo.preload(:photographer).where(enabled: true)

    relation = relation.where(category: filter[:category].to_i) if filter[:category]

    relation.page(page)
  end
end
