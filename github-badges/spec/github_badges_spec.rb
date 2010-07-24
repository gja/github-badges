require 'spec_helper'

describe "Github badges" do
  it "should render a user's name when you request their badge page" do
    Octopi::User.expects(:find).with("cv").returns mock(:name => "Carlos")
    get "/users/cv"
    last_response.body.should include("Carlos")
  end
end