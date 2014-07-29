module ControllerMacros
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:user)
      user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
      sign_in user
    end
  end
end

module Codly
  module RequestTestHelpers
    def sign_in(user)
      visit root_path
      click_link "login"

      page.current_path.should == new_user_session_path

      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      click_on "Sign in"

      page.should have_content "Signed in"
    end
  end
end

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.extend ControllerMacros, :type => :controller
  config.include Codly::RequestTestHelpers, :type => :request
end