class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    cookies[:current_user_id] ||= User.all.sample.id
    @_current_user ||= User.find(cookies[:current_user_id])
  end
end
