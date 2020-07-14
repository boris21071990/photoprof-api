class ApplicationController < ActionController::API
  include ExceptionHandler
  include ResponseRenderer
  include UserAuthentication
end
