module Api
  module V1
    class AuthenticationController < ApplicationController
      before_action :authorize_refresh_request!, only: :refresh

      def login
        login_user = LoginUser.new(email: login_params[:email], password: login_params[:password]).call

        if login_user.success?
          user = login_user.data[:user]

          render_data_with_tokens(user)
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
          user = register_user.data[:user]

          render_data_with_tokens(user)
        else
          render_errors register_user.errors
        end
      end

      def refresh
        user = User.find_by(id: payload["user_id"])

        if user.blank?
          render_errors([{ type: "authorization", message: "Unauthorized user" }], status: 401) && return
        end

        payload_data = { user_id: user.id }

        tokens = JWTSessions::Session.new(payload: payload_data, refresh_payload: payload_data).refresh(found_token)

        cookies["XSRF-TOKEN"] = tokens[:csrf]

        data = { token: tokens[:access] }

        render_data data
      end

      private

      def login_params
        params.require(:login).permit(:email, :password)
      end

      def registration_params
        params.require(:registration).permit(:email, :password, :first_name, :last_name, :city_id)
      end

      def render_data_with_tokens(user)
        payload_data = { user_id: user.id }

        tokens = JWTSessions::Session.new(payload: payload_data, refresh_payload: payload_data).login

        cookies[JWTSessions.refresh_cookie] = { value: tokens[:refresh], httponly: true }
        cookies["XSRF-TOKEN"] = tokens[:csrf]

        data = { token: tokens[:access] }

        render_data data
      end
    end
  end
end
