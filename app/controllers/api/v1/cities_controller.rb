module Api
  module V1
    class CitiesController < ApplicationController
      def index
        render_resources(CitiesFetcher.call, with: CitySerializer, paginate: false)
      end
    end
  end
end
