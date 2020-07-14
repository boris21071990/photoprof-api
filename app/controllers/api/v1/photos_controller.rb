module Api
  module V1
    class PhotosController < ApplicationController
      def index
        render_resources(PhotosFetcher.call(photos_params[:page],
                                            category: photos_params[:category]),
                         with: PhotoItemSerializer)
      end

      def show
        photo = PhotoFetcher.call(params[:id])

        ViewsUpdateJob.perform_later(photo, request.ip, Date.today)

        render_resource photo, with: PhotoItemSerializer
      end

      private

      def photos_params
        params.permit(:page, :category).with_defaults(page: 1)
      end
    end
  end
end
