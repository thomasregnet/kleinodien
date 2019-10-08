class ApplicationController < ActionController::Base
  include Pundit
  # TODO: Ensure Pundit policies and scopes are used
  # https://github.com/varvet/pundit#ensuring-policies-and-scopes-are-used

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
