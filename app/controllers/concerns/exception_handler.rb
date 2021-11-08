module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
  end

  private

  def not_found
    render status: 404,
           json: { data: nil, errors: [{ type: "not_found", message: "Sorry, not found." }] }
  end
end
