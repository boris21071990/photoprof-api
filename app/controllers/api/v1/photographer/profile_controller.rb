module Api
  module V1
    module Photographer
      class ProfileController < ApplicationController
        before_action :authenticate_user

        def index
          photographer = current_user.photographer

          render_resource photographer, with: PhotographerSerializer
        end

        def update
          photographer = current_user.photographer

          photographer_updater = PhotographerUpdater.new(photographer, photographer_params).call

          if photographer_updater.success?
            render_resource photographer_updater.data[:photographer], with: PhotographerSerializer
          else
            render_errors photographer_updater.errors
          end
        end

        def update_image
          photographer = current_user.photographer

          photographer_image_updater = PhotographerImageUpdater.new(photographer, photographer_params[:image]).call

          if photographer_image_updater.success?
            render_data photographer_image_updater.data
          else
            render_errors photographer_image_updater.errors
          end
        end

        private

        def photographer_params
          params.require(:photographer).permit(:first_name, :last_name, :city_id, :description, :image)
        end
      end
    end
  end
end
