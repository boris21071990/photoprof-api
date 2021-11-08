class Result
  attr_reader :success, :data, :errors

  def initialize(success, data, errors)
    @success = success
    @data = data
    @errors = errors
  end

  def success?
    @success
  end

  def failure?
    !@success
  end

  def self.success(data = nil)
    new(true, data, [])
  end

  def self.failure(errors = [])
    new(false, nil, Array.wrap(errors))
  end
end
