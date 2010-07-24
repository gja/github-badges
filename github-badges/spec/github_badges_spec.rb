require 'spec_helper'

describe "Github badges" do
  it "should render a user's name when you request their badge page" do
    Octopi::User.expects(:find).with("cv").returns mock(:name => "Carlos")
    get "/users/cv"
    last_response.body.should have_tag(".user .name", /Carlos/)
  end
  
  it "should render a 1 repository badge if user has at least 1 repository" do
    Octopi::User.expects(:find).with("cv").returns mock(:name => "cv", :public_repo_count => 1)
    get "/users/cv"
    last_response.body.should have_tag("ul.badges li.badge", /1 repository badge/)
  end
end
