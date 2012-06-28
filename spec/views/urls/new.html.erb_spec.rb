require 'spec_helper'

describe "urls/new" do
  before(:each) do
    assign(:url, stub_model(Url,
      :full_url => "MyString",
      :short_url => "MyString",
      :redirect_count => 1
    ).as_new_record)
  end

  it "renders new url form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => urls_path, :method => "post" do
      assert_select "input#url_full_url", :name => "url[full_url]"
      assert_select "input#url_short_url", :name => "url[short_url]"
      assert_select "input#url_redirect_count", :name => "url[redirect_count]"
    end
  end
end
