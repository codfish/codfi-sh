require 'spec_helper'

describe User do

  context "associations" do
    it { should have_many(:urls).through(:user_urls) }
    it { should have_many(:user_urls) }
  end

  context "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
  end

  context "fabricators" do
    let(:user) { Fabricate.build(:user) }

    it "creates a valid user" do
      user.save.should === true
    end
  end

  context "registration" do
    it "should allow a user to register" do
      user = User.new(name: "Chris", email: "codonnell822@gmail.com", password: "password")
      user.save.should === true
    end
  end

end
