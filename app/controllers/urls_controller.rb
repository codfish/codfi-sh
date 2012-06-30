class UrlsController < ApplicationController

  before_filter :authenticate_user!, :only => [:edit, :update, :destroy]
  before_filter :get_url, :only => [ :edit, :show, :update, :destroy ]
  
  respond_to :html, :json
	
  def index
    if params[:user_id]
      @urls = current_user.urls.unscoped.order("redirect_count DESC")
      @page_header = "My Short Urls"
    elsif params[:popular]
      @urls = Url.unscoped.order("redirect_count DESC")
      @page_header = "Most Popular Short Urls"
    else
      @urls = Url.unscoped.order("created_at DESC")
      @page_header = "Latest Urls"
    end
    
    @url = Url.new	  
  end
  
  def show
  end
  
  def new
    @url = Url.new
  end
  
  def edit
  end
  
  def create
    @url = Url.new(params[:url]) unless (@url = Url.find_by_full_url(params[:url][:full_url]))
    @url.users << current_user if (user_signed_in?)

    flash[:notice] = "Short url was successfully created." if @url.save
    respond_with @url
  end
  
  def update
    if @url.update_attributes(params[:url])
      redirect_to @url, notice: 'Url was successfully updated.'
    else
      render action: "edit"
    end
  end
  
  def destroy
    @url = Url.find(params[:id])
    @url.destroy		
    redirect_to urls_url
  end
  
  def redirect
    if @url = Url.find_by_short_url(params[:short_url])
      @url.dont_shorten_me
      @url.increment_redirect_count
      redirect_to @url.full_url
    else
      redirect_to urls_url
    end
  end
  
  private 
  
  def get_url
    @url = Url.find(params[:id])
  end
end
