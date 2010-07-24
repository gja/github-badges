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

  it "should not render any badges if the user matches no badges" do
    Octopi::User.stubs(:find).with("cv").returns stub(:name => "cv", :public_repo_count => 0)
    get "/badges/cv"
    last_response.body.should_not have_tag("ul#badges")
    last_response.body.should have_tag(".sadpanda", "The user you've requested does not have any badges.")
  end

  it "should render a badge if user matches the criteria for that badge repository" do
    Badge.add(:name => "Has a repo") { |user| user.public_repo_count == 1 }

    Octopi::User.stubs(:find).with("cv").returns stub(:name => "cv", :public_repo_count => 1)
    get "/badges/cv"
    last_response.body.should have_tag("ul#badges li.badge", /Has a repo/)

    Octopi::User.stubs(:find).with("bguthrie").returns stub(:name => "bguthrie", :public_repo_count => 0)
    get "/badges/bguthrie"
    last_response.body.should_not have_tag("ul#badges li.badge", /Has a repo/)
  end

  it "should render both the name and the description of a badge" do
    Badge.add(:name => "Truth-haver", :description => "Word") { true }

    Octopi::User.stubs(:find).with("foo").returns stub(:name => "foo")
    get "/badges/foo"
    last_response.body.should have_tag("ul#badges li.badge .name", "Truth-haver")
    last_response.body.should have_tag("ul#badges li.badge .description", "Word")
  end

end
