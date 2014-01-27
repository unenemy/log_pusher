class HomeController < ApplicationController
  def index
    case params[:log]
      when "warn" then Rails.logger.warn("WARNING really warning message")
    end
  end
end