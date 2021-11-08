module Api
  module V1
    class PhotosController < ApplicationController
      def index
        render_resources(PhotosFetcher.call(photos_params), with: PhotoItemSerializer)
      end

      def show
        photo = PhotoRepository.find_enabled_by_id!(params[:id])

        ViewsUpdateJob.perform_later(photo, request.ip, Date.today)

        render_resource photo, with: PhotoItemSerializer
      end

      private

      def photos_params
        params.permit(:page, :category_id, :sort, :per_page).with_defaults(page: 1)
      end
    end
  end
end
