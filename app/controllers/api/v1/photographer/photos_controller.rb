module Api
  module V1
    module Photographer
      class PhotosController < ApplicationController
        before_action :authenticate_user

        def index
          photos = current_user.photographer.photos

          render_resources photos, with: PhotoSerializer, paginate: false
        end

        def create
          photographer = current_user.photographer

          photo_creator = PhotoCreator.new(photographer, photo_params).call

          if photo_creator.success?
            render_resource photo_creator.data[:photo], with: PhotoSerializer
          else
            render_errors photo_creator.errors
          end
        end

        private

        def photo_params
          params.require(:photo).permit(:image)
        end
      end
    end
  end
end
