class PhotographersFetcher
  def self.call(page = 1, filter = {})
    relation = Photographer.preload(:city, :categories, :enabled_photos).where(enabled: true)

    if filter[:category]
      relation = relation.distinct.joins(:categories).where(categories: { id: filter[:category].to_i })
    end

    relation.page(page)
  end
end
