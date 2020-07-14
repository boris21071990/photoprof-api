class PhotographerUpdater
  attr_reader :photographer, :photographer_params

  def initialize(photographer, photographer_params = {})
    @photographer = photographer
    @photographer_params = photographer_params
  end

  def call
    unless photographer_form.valid?
      errors = photographer_form.errors.full_messages.map { |message| { type: "validation", message: message } }

      return Result.failure(errors)
    end

    photographer.update(first_name: photographer_params[:first_name],
                        last_name: photographer_params[:last_name],
                        city_id: photographer_params[:city_id],
                        description: photographer_params[:description])

    Result.success(photographer: photographer)
  end

  private

  def photographer_form
    @photographer_form ||= PhotographerForm.new(first_name: photographer_params[:first_name],
                                                last_name: photographer_params[:last_name],
                                                city_id: photographer_params[:city_id])
  end
end
