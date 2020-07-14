module Api
  module V1
    class PhotographersController < ApplicationController
      def index
        render_resources(PhotographersFetcher.call(photographers_params[:page],
                                                   category: photographers_params[:category]),
                         with: PhotographerItemSerializer)
      end

      def show
        photographer = PhotographerFetcher.call(params[:id])

        render_resource photographer, with: PhotographerViewSerializer
      end

      private

      def photographers_params
        params.permit(:page, :category).with_defaults(page: 1)
      end
    end
  end
end
