require "spec_helper"

describe "user registration", :type => :feature do
  it "allows new users to register with an email address and password" do
    visit "/users/sign_up"

    fill_in "Name",                  :with => "Charles in Charge"
    fill_in "Email",                 :with => "alindeman@example.com"
    fill_in "Password",              :with => "strawberrrrry"
    fill_in "Password confirmation", :with => "strawberrrrry"

    click_button "Sign up"

    page.should have_content("Welcome! You have signed up successfully.")
  end

  it "does not allow new users to register with incorrect confirmation password" do
    visit "/users/sign_up"

    fill_in "Name",                  :with => "Charles in Charge"
    fill_in "Email",                 :with => "alindeman@example.com"
    fill_in "Password",              :with => "strawberrrrry"
    fill_in "Password confirmation", :with => "grapes23"

    click_button "Sign up"

    page.should have_content("Password doesn't match confirmation")
  end
end

describe "user sign in", :type => :feature do
  it "allows users to sign in after they have registered" do
    user = User.create(:name                  => "alindeman",
                       :email                 => "alindeman@example.com",
                       :password              => "ilovegrapes",
                       :password_confirmation => "ilovegrapes")

    visit "/users/sign_in"

    fill_in "Email",    :with => "alindeman@example.com"
    fill_in "Password", :with => "ilovegrapes"

    click_button "Sign in"

    page.should have_content("Signed in successfully.")
  end

  it "doesn't sign in user with wrong credentials" do
    user = User.create(:email    => "alindeman@example.com",
                       :password => "ilovegrapes")

    visit "/users/sign_in"

    fill_in "Email",    :with => "alindeman@example.com"
    fill_in "Password", :with => "grapes"

    click_button "Sign in"

    page.should have_content("Invalid email or password.")
  end
end