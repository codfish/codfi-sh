require 'spec_helper'
include Devise::TestHelpers

describe UrlsController do

  def valid_attributes
    { full_url: "http://www.testingisannoying.com" }
  end
  
  describe "when logged out" do
    it "GET#edit should not respond successfully" do
      get :edit
      response.should_not be_success
    end
  end
  
  describe "when logged in" do
	  before { sign_in user }
    let(:user) { User.create(name: "Charlie", email: "user@email.com", password: "password")}
  
    it "GET#index assigns all urls as @urls" do
      url = Url.create! valid_attributes
      get :index, {}
      assigns(:urls).should eq([url])
    end


    it "GET#show assigns the requested url as @url" do
      url = Url.create! valid_attributes
      get :show, {:id => url.to_param}
      assigns(:url).should eq(url)
    end

    it "GET#new assigns a new url as @url" do
      get :new, {}
      assigns(:url).should be_a_new(Url)
    end

    it "GET#edit assigns the requested url as @url" do
      url = Url.create! valid_attributes
      get :edit, {:id => url.to_param}
      assigns(:url).should eq(url)
    end

	  describe "POST create" do
	    describe "with valid params" do
	      it "creates a new Url" do
	        expect {
	          post :create, {:url => valid_attributes}
	        }.to change(Url, :count).by(1)
	      end
	
	      it "assigns a newly created url as @url" do
	        post :create, {:url => valid_attributes}
	        assigns(:url).should be_a(Url)
	        assigns(:url).should be_persisted
	      end
	
	      it "redirects to the created url" do
	        post :create, {:url => valid_attributes}
	        response.should redirect_to(Url.last)
	      end
	    end
	
	    describe "with invalid params" do
	      it "assigns a newly created but unsaved url as @url" do
	        # Trigger the behavior that occurs when invalid params are submitted
	        Url.any_instance.stub(:save).and_return(false)
	        post :create, {:url => {}}
	        assigns(:url).should be_a_new(Url)
	      end
	    end
	  end
	
	  describe "DELETE destroy" do
	    it "destroys the requested url" do
	      url = Url.create! valid_attributes
	      expect {
	        delete :destroy, {:id => url.to_param}
	      }.to change(Url, :count).by(-1)
	    end
	
	    it "redirects to the urls list" do
	      url = Url.create! valid_attributes
	      delete :destroy, {:id => url.to_param}
	      response.should redirect_to(urls_url)
	    end
	  end
  end

end
