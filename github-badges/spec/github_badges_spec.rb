require 'spec_helper'

describe "Github badges" do
  it "should render a user's name when you request their badge page" do
    Octopi::User.stubs(:find).with("cv").returns stub(:name => "Carlos", :public_repo_count => 0)
    get "/users/cv"
    last_response.body.should have_tag(".user .name", /Carlos/)
  end
  
  it "should not render any badges if the user matches no badges" do
    Octopi::User.stubs(:find).with("cv").returns stub(:name => "cv", :public_repo_count => 0)
    get "/users/cv"
    last_response.body.should_not have_tag("ul.badges")
    last_response.body.should have_tag(".sadpanda", "The user you've requested does not have any badges.")
  end
  
  it "should render a 1 repository badge if user has at least 1 repository" do
    Octopi::User.stubs(:find).with("cv").returns stub(:name => "cv", :public_repo_count => 1)
    get "/users/cv"
    last_response.body.should have_tag("ul.badges li.badge", /1 repository badge/)
  end
end
