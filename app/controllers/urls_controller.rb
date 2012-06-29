class UrlsController < ApplicationController

	before_filter :authenticate_user!, :only => [:edit, :update, :destroy]
  before_filter :get_url, :only => [ :edit, :show, :update, :destroy ]
  
 # default_scope order("updated_at")

  def index
  	if user_signed_in?
	  	@urls = current_user.urls.all
  	else
	    @urls = Url.all
	  end
	  
	  if params[:popular]
	  	
	  end
  end

  def show
  end

  def new
    @url = Url.new
  end

  def edit
  end
  
  def create
	  @url = Url.find_by_full_url(params[:url][:full_url])
	  if user_signed_in? 
	  	@user_url_exists = current_user.urls.find_by_full_url(params[:url][:full_url])
		end
	  
	  if (@url)
	  	if @user_url_exists
	  		redirect_to urls_url, notice: 'You already created that short url.' and return
	  	else
	  		@url.users << current_user if (user_signed_in?)
	  	end
	  else
			@url = Url.new(params[:url])
		  @url.users << current_user if (user_signed_in?)
	  end
	  
	  if (@url.valid? && @url.short_url)
	  	@url.dont_shorten_me!
	  end
	  
	  if @url.save
      redirect_to urls_url
    else
      render action: "new"
    end
		
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
    	@url.increment_redirect_count!
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
