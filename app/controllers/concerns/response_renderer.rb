module ResponseRenderer
  def render_resource(resource, with:, status: 200)
    render status: status,
           json: { data: ActiveModelSerializers::SerializableResource.new(resource, serializer: with), errors: nil }
  end

  def render_resources(resources, with:, status: 200, paginate: true)
    render status: status,
           json: { data: ActiveModelSerializers::SerializableResource.new(resources, each_serializer: with),
                   errors: nil,
                   meta: paginate ? { pagination: pagination(resources) } : {} }
  end

  def render_data(data, status: 200)
    render status: status,
           json: { data: data, errors: nil }
  end

  def render_errors(errors, status: 422)
    render status: status, json: { data: nil, errors: errors }
  end

  private

  def pagination(resources)
    {
        per_page: resources.limit_value,
        total_pages: resources.total_pages,
        total_records: resources.total_count
    }
  end
end
