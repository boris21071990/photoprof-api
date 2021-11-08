class ApplicationController < ActionController::API
  include ::ActionController::Cookies
  include ExceptionHandler
  include ResponseRenderer
  include UserAuthentication
end
