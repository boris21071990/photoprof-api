module Api
  module V1
    class CitiesController < ApplicationController
      def index
        render_resources(CityRepository.all, with: CitySerializer, paginate: false)
      end
    end
  end
end
