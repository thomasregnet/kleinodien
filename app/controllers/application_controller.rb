# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  # TODO: Ensure Pundit policies and scopes are used
  # https://github.com/varvet/pundit#ensuring-policies-and-scopes-are-used
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action'
    redirect_to(request.referrer || root_path)
  end
end
