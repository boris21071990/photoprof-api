class PhotographersFetcher
  MAX_PER_PAGE = 20
  DEFAULT_ORDER = :created_at
  ALLOWED_SORT_FIELDS = %w(created_at).freeze

  def self.call(filter = {})
    where_condition = {}

    where_condition[:category_ids] = filter[:category_id].to_i if filter[:category_id].present?
    where_condition[:city_id] = filter[:city_id].to_i if filter[:city_id].present?

    order = SortOrderBuilder.call(filter[:sort], ALLOWED_SORT_FIELDS, DEFAULT_ORDER)

    page = filter[:page] || 1

    per_page = if filter[:per_page].present? && (1..MAX_PER_PAGE).include?(filter[:per_page].to_i)
                 filter[:per_page].to_i
               else
                 MAX_PER_PAGE
               end

    Photographer.search("*", where: where_condition,
                        includes: [:city, :categories, :enabled_photos],
                        order: order,
                        page: page,
                        per_page: per_page)
  end
end
