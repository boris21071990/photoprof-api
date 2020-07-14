module Api
  module V1
    class AuthenticationController < ApplicationController
      def login
        login_user = LoginUser.new(email: login_params[:email], password: login_params[:password]).call

        if login_user.success?
          render_data login_user.data
        else
          render_errors login_user.errors
        end
      end

      def register
        register_user = RegisterUser.new(email: registration_params[:email],
                                         password: registration_params[:password],
                                         first_name: registration_params[:first_name],
                                         last_name: registration_params[:last_name],
                                         city_id: registration_params[:city_id]).call

        if register_user.success?
          render_data register_user.data
        else
          render_errors register_user.errors
        end
      end

      private

      def login_params
        params.permit(:email, :password)
      end

      def registration_params
        params.permit(:email, :password, :first_name, :last_name, :city_id)
      end
    end
  end
end
