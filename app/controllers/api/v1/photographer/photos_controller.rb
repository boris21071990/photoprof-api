module Api
  module V1
    module Photographer
      class PhotosController < BasePhotographerController
        def index
          photos = current_photographer.photos.order(id: :desc)

          render_resources photos, with: PhotoSerializer, paginate: false
        end

        def create
          photo_creator = PhotoCreator.new(current_photographer, photo_params).call

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
