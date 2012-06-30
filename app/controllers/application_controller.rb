class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found
  rescue_from NoMethodError, :with => :error_page if Rails.env == "production"

	private
	
  def not_found
    render :file => "public/404.html", :status => 404
  end
  
  def error_page
    flash[:error] = "There was an error on the page."
    render :file => "public/404.html", :status => 404
  end
end
