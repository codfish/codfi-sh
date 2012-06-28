require 'spec_helper'

describe "urls/show" do
  before(:each) do
    @url = assign(:url, stub_model(Url,
      :full_url => "Full Url",
      :short_url => "Short Url",
      :redirect_count => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Full Url/)
    rendered.should match(/Short Url/)
    rendered.should match(/1/)
  end
end
