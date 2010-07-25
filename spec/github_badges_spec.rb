require 'spec_helper'

describe "Github badges" do
  before :each do
    Badge.clear_badges!
  end

  it "should render a user's name when you request their badge page" do
    Octopi::User.stubs(:find).with("cv").returns stub(:name => "Carlos", :public_repo_count => 0)
    get "/badges/cv"
    last_response.body.should have_tag(".user .intro", /Carlos/)

    Octopi::User.stubs(:find).with("bguthrie").returns stub(:name => "Brian", :public_repo_count => 0)
    get "/badges/bguthrie"
    last_response.body.should have_tag(".user .intro", /Brian/)
  end

  it "should render a badge if user matches the criteria for that badge repository" do
    Badge.add(:measure => :public_repo_count, :target => 1)

    Octopi::User.stubs(:find).with("cv").returns stub(:name => "cv", :public_repo_count => 1)
    get "/badges/cv"
    last_response.body.should have_tag("ul#badges li.badge.complete")
  end

  it "should render an incomplete badge if the target of the badge has not been achieved" do
    Badge.add(:measure => :public_repo_count, :target => 1)
    Octopi::User.stubs(:find).with("bguthrie").returns stub(:name => "bguthrie", :public_repo_count => 0)

    get "/badges/bguthrie"
    last_response.body.should have_tag("ul#badges li.badge.incomplete")
  end

  it "should render both the name and the description of a badge" do
    Badge.add(:name => "Truth-haver", :description => "Word", :target => lambda { true }, :measure => :foo)
    Octopi::User.stubs(:find).with("foo").returns stub(:name => "foo")

    get "/badges/foo"
    last_response.body.should have_tag("ul#badges li.badge") do
      have_tag(".name", "Truth-haver")
      have_tag(".description", "Word")
    end
  end

end