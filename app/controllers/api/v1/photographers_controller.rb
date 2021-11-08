module Api
  module V1
    class PhotographersController < ApplicationController
      def index
        render_resources(PhotographersFetcher.call(photographers_params), with: PhotographerItemSerializer)
      end

      def show
        photographer = PhotographerRepository.find_enabled_by_slug!(params[:id])

        render_resource photographer, with: PhotographerViewSerializer
      end

      private

      def photographers_params
        params.permit(:page, :category_id, :city_id, :sort, :per_page).with_defaults(page: 1)
      end
    end
  end
end
