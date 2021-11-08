module Api
  module V1
    class UserController < ApplicationController
      before_action :authorize_by_access_header!

      def index
        render_resource current_user, with: UserSerializer
      end
    end
  end
end
