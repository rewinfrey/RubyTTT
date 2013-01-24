class ApplicationController < ActionController::Base
  protect_from_forgery

  def reset_cookies
    cookies[:game_id] = nil
  end
end
