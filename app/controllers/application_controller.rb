class ApplicationController < ActionController::Base
  include TheComments::ViewToken
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #before_action :set_locale

  #def set_locale
  #  I18n.locale = params[:locale] || I18n.default_locale
  #end

  def after_sign_in_path_for(resource)
    root_user_path
  end

  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end
end
