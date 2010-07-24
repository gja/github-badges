require 'spec_helper'

describe BadgeUser do
  before :each do
    Octopi::User.stubs(:find).returns "a github user"
  end
  
  context "find" do
    it "should search Github for the user" do
      Octopi::User.expects(:find).with("cv")
      BadgeUser.find("cv")
    end
  end
  
  context "badges" do
    it "should have no badges if the user has no repositories on GitHub" do
      BadgeUser.new(stub(:public_repo_count => 0)).badges.should be_empty
    end
    
    it "should have one badge if the user has one repository on Github" do
      BadgeUser.new(stub(:public_repo_count => 1)).badges.size.should == 1
    end
  end
end