module Api
  module V1
    module Photographer
      class BasePhotographerController < ApplicationController
        attr_reader :current_photographer

        before_action :authorize_by_access_header!
        before_action :find_current_photographer

        def find_current_photographer
          unless current_user.role == User::ROLE_PHOTOGRAPHER
            render_errors([{ type: "authorization", message: "Unauthorized user" }]) && return
          end

          @current_photographer = ::Photographer.find_by!(user: current_user)
        end
      end
    end
  end
end
