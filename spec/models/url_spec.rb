require 'spec_helper'

describe Url do

  context "associations" do
    it { should have_many(:users).through(:user_urls) }
    it { should have_many(:user_urls) }
  end

  context "validations" do
    let(:url) { Fabricate.build(:url) }
    it { url.should validate_presence_of :full_url }
#     it { url.should match(/^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix) }
  end

  context "fabricators" do
    let(:url) { Fabricate.build(:url) }

    it "creates a valid url" do
      url.save.should === true
    end
  end

  context "registration" do
    it "should allow a user to register" do
      url = Url.new(full_url: "http://www.testingisannoying.com")
      url.save.should === true
    end
  end

  context "shortening" do
    let(:url) { Fabricate.build(:url) }

    it "should generate a short url" do
      url.save.should === true
      url.short_url.should_not be_nil
    end

    it "should be a 6 character string" do
      url.save.should === true
      url.short_url.should be_a_kind_of(String)
    end

    it "should not fail on shortening a Url that's already been shortened" do
      url = Url.new(full_url: "http://www.testingisannoying.com")
      url.save.should === true
      ur12 = Url.new(full_url: "http://www.testingisannoying.com")
      url2.save.should === true
    end

    it "should not re-shorten a Url that's already been shortened" do
      ur1 = Url.new(full_url: "http://www.testingisannoying.com")
      url.save.should === true
      ur12 = Url.new(full_url: "http://www.testingisannoying.com")
      url2.save.should === true
      url2.short_url.should === url.short_url
    end

    it "should increment the shortened count" do
      url.save.should === true
      url.shortened_count.should === 1
    end
  end

end
