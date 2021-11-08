class SortOrderBuilder
  def self.call(sort, allowed_sort_fields = [], default_order)
    return default_order if sort.blank?

    order = sort.split(",").each_with_object({}) do |sort_field, result|
      if sort_field.start_with?("-")
        sort_field = sort_field[1..-1]

        result[sort_field] = :desc
      else
        result[sort_field] = :asc
      end
    end

    allowed_sort_fields = allowed_sort_fields.map(&:to_s)

    order.select! { |key, _| allowed_sort_fields.include?(key) }

    order.present? ? order : default_order
  end
end
