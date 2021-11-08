module Api
  module V1
    class CategoriesController < ApplicationController
      def index
        render_resources(CategoryRepository.all, with: CategorySerializer, paginate: false)
      end
    end
  end
end
