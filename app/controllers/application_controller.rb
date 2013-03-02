require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html, :js

  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    begin
      redirect_to :back, :alert => exception.message.html_safe
    rescue ActionController::RedirectBackError
      redirect_to chapters_path, :alert => exception.message.html_safe
    end
  end

  def after_sign_in_path_for(resource)
    lessons_path
  end

  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end
end
